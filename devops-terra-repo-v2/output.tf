
output "salida" {
  value = local.branch_protections
}

output "branch_protection" {
  description = "protection_repository"
  value       = local.protection_repository
}
