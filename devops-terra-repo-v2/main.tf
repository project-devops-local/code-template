resource "github_repository" "this" {
  for_each               = var.repositories
  name                   = each.value
  description            = var.description
  visibility             = var.visibility
  has_issues             = var.has_issues
  allow_merge_commit     = var.allow_merge_commit
  allow_squash_merge     = var.allow_squash_merge
  allow_rebase_merge     = var.allow_rebase_merge
  delete_branch_on_merge = var.delete_branch_on_merge
  auto_init              = var.auto_init
  is_template            = var.is_template
  vulnerability_alerts   = var.vulnerability_alerts

  template {
    owner      = var.template.owner
    repository = var.template.repository
  }

  lifecycle {
    ignore_changes = [
      auto_init,
      template,
    ]
  }
}


output "salida_repositorios" {
  description = "ver la salida de los repositorios"
  value       = local.team_repository
  depends_on = [
    github_repository.this
  ]
}

output "listTeamRepo" {
  description = "prueba team_repo"
  value = local.team_repository
}

resource "github_team_repository" "this" {
  for_each = {
    for team in local.team_repository : "${team.team_name}.${team.repository_name}" => team 
  }

  team_id    = each.value.team_id
  repository = each.value.repository_name
  permission = each.value.permission

}


resource "github_branch_default" "this" {
  for_each   = github_repository.this
  repository = each.value.name

  branch = "main"
  depends_on = [
    github_repository.this
  ]
}



resource "github_branch" "this" {
  //for_each   = var.branches
  for_each = { 
    for obj in local.branch_repository : "${obj.branch}.${obj.repository_name}" => obj
    if obj.branch != "main"
  }

    repository = each.value.repository_name
    branch     = each.value.branch
    depends_on = [
      github_branch_default.this
    ]
}


resource "github_branch_protection" "protection_repository" {
  //depends_on = [ github_repository_file.this ]
  for_each               = { for  protection in local.protection_repository : "${protection.repository_name}.${protection.rama}" => protection }
  repository_id          = each.value.branch_repository
  pattern                = each.value.branch_protections.pattern
  enforce_admins         = each.value.branch_protections.enforce_admins
  require_signed_commits = each.value.branch_protections.require_signed_commits


  required_status_checks {
    strict   = each.value.branch_protections.required_status_checks.strict
    contexts = each.value.branch_protections.required_status_checks.contexts
  }

  required_pull_request_reviews {

    dismiss_stale_reviews           = each.value.branch_protections.required_pull_request_reviews.dismiss_stale_reviews
    dismissal_restrictions          = each.value.branch_protections.required_pull_request_reviews.dismissal_restrictions
    require_code_owner_reviews      = each.value.branch_protections.required_pull_request_reviews.require_code_owner_reviews
    required_approving_review_count = each.value.branch_protections.required_pull_request_reviews.required_approving_review_count

  }

  depends_on = [
    github_branch.this
  ]
}
