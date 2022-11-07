locals {
  team_membership = flatten([
    for team_key, team in var.teams : [
      for member in team.members : {
        team       = team_key != "porv-common-devops" ? team_key : "porv-common-devops"
        team_id    = team_key != "porv-common-devops" ? github_team.teams[team_key].id : null
        user_name  = team_key != "porv-common-devops" ? member : null
        permission = team.permission
      }
    ]
  ])

  team_permission = flatten([
    for team_key, team in var.teams : {
      team_name  = team_key
      team_id    = team_key != "porv-common-devops" ? github_team.teams[team_key].id : data.github_team.this[team_key].id
      permission = team.permission
    }
  ])


}
