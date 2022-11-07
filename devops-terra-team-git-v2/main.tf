resource "github_team" "teams" {
  for_each = { for name, team in var.teams : name => team
    if name != "porv-common-devops"
  }
  name        = each.key
  description = each.value.description
  privacy     = "closed"
}

resource "github_team_membership" "members" {
  for_each = {
    for member in local.team_membership : "${member.team}.${member.user_name}" => member
    if member.team != "porv-common-devops"
  }


  team_id  = each.value.team_id
  username = each.value.user_name
}

data "github_team" "this" {
  for_each = var.teams
  slug     = each.key

  depends_on = [
    github_team.teams
  ]
}
