variable "name" {
  type        = string
  description = "Nombre del repositorio"
  default     = ""
}

variable "repositories" {
  default     = []
  type        = set(string)
  description = "All repository"
  validation {
    condition     = length(var.repositories) > 0
    error_message = "Por favor registra por lo menos un repositorio"
  }
}

variable "description" {
  type        = string
  description = "(Opcional) private default visibility private"
  default     = ""
}

variable "visibility" {
  type        = string
  description = "(Opcional) private default visibility private"
  default     = "private"
}


variable "has_issues" {
  type        = bool
  description = "(Opcional) private default visibility private"
  default     = false
}



variable "allow_merge_commit" {
  type        = bool
  description = "(Opcional) private default visibility private"
  default     = true
}

variable "allow_squash_merge" {
  type        = bool
  description = "(Opcional) private default visibility private"
  default     = false
}

variable "allow_rebase_merge" {
  type        = bool
  description = "(Opcional) private default visibility private"
  default     = false
}

variable "delete_branch_on_merge" {
  type        = bool
  description = "(Opcional) private default visibility private"
  default     = true
}


variable "auto_init" {
  type        = bool
  description = "(Opcional) private default visibility private"
  default     = true
}

variable "is_template" {
  type        = bool
  description = "(Opcional) private default visibility private"
  default     = false
}

variable "vulnerability_alerts" {
  type        = bool
  description = "(Opcional) private default visibility private"
  default     = true
}


variable "teams" {
  type        = any
  description = "variable de equipos"
  default     = []
}


variable "teams_permission" {
  type        = any
  description = "variable de equipos"
  default     = []
}


variable "template" {
  type = object({
    owner      = string
    repository = string
  })

  default = {
    owner      = "laboratory-terra-github"
    repository = "devops-template-terra"
  }

}





variable "branches" {
  type        = set(string)
  description = "Ramas por defecto para el modulo de repositorios"
  default     = ["main", "develop", "release"]
}


variable "branch_protections" {
  description = "Definicion de proteccion de las ramas."
  type        = any
  default = [
    {
      pattern                = "main"
      enforce_admins         = true
      require_signed_commits = true
      required_status_checks = {
        strict   = true
        contexts = ["ci/jenkins"]
      }

      required_pull_request_reviews = {
        dismiss_stale_reviews           = true
        dismissal_restrictions          = []
        require_code_owner_reviews      = true
        required_approving_review_count = 2
      }
    },
    {
      pattern                = "develop"
      enforce_admins         = true
      require_signed_commits = true
      required_status_checks = {
        strict   = true
        contexts = []
      }
      required_pull_request_reviews = {
        dismiss_stale_reviews           = true
        dismissal_restrictions          = []
        require_code_owner_reviews      = true
        required_approving_review_count = 2
      }
    },
    {
      pattern                = "release"
      enforce_admins         = true
      require_signed_commits = true
      required_status_checks = {
        strict   = true
        contexts = []
      }
      required_pull_request_reviews = {
        dismiss_stale_reviews           = true
        dismissal_restrictions          = []
        require_code_owner_reviews      = true
        required_approving_review_count = 2
      }
    },
  ]
}
