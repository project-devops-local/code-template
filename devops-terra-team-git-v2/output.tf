
output "teams" {
  description = "salida de equipos creados"
  value       = data.github_team.this
}

output "team_permission" {
  description = "prueba de team permission"
  value       = local.team_permission
  depends_on = [
    github_team.teams
  ]
}
