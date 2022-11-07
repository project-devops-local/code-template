locals {
  branch_protections = [
    for data in var.branch_protections : merge({
      pattern                       = null
      enforce_admins                = null
      require_signed_commits        = null
      required_status_checks        = {}
      required_pull_request_reviews = {}
    }, data)
  ]


  required_status_checks = [
    for data in local.branch_protections :
    length(keys(data.required_status_checks)) > 0 ? [
      merge({
        strict   = null
        contexts = []
      }, data.required_status_checks)
    ] : []
  ]

  required_pull_request_reviews = [
    for data in local.branch_protections :
    length(keys(data.required_pull_request_reviews)) > 0 ? [
      merge({
        dismiss_stale_reviews           = true
        dismissal_restrictions          = []
        require_code_owner_reviews      = null
        required_approving_review_count = null
      }, data.required_pull_request_reviews)

    ] : []

  ]
}

locals {
  team_repository = flatten([
    for repository_key, repository in github_repository.this : [
      for team in var.teams_permission : {
        repository_name     = repository_key
        respository_node_id = repository.node_id
        team_id             = team.team_id
        permission          = team.permission
        team_name           = team.team_name
      }

    ]

  ])

  branch_repository = flatten([
    for branch_repository in github_repository.this : [
      for branch in var.branches : {
        repository_name = branch_repository.name
        branch          = branch
      }

    ]

  ])



  protection_repository = flatten([
    for branch_repository in github_repository.this : [
      for branch in local.branch_protections : {
        rama = branch.pattern
        branch_protections = branch
        branch_repository  = branch_repository.node_id
        repository_name    = branch_repository.name

      }

    ]

  ])







}
