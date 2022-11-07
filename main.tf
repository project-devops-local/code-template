module "teams_github" {
  source = "./devops-terra-team-git-v2"
  //Los permisos que se pueden aplicar son: 
  /*
    * admin -> administrador de los repositorios
    * triage -> aprobador pull request
    * pull -> permisos de lectura
    * push -> permisos de write
  
  */
  teams = {
    "devops_reviewers" = {
      description = "equipo de prueba teams devops_reviewers"
      members     = ["davila97", "maikol1995"]
      permission  = "push"
    }
    /*
    "devops_tester" = {
      description = "equipo de prueba teams devops_tester"
      members     = ["davila97", "maikol1995"]
      permission  = "pull"
    }
    
    "devops_testermodificado2" = {
      description = "Equipo de prueba teams devops_tester"
      members     = ["davila97","maikol1995"]
      permission  = "pull"
    }*/
    "devops_testermodificado3" = {
      description = "Equipo de prueba teams devops_tester"
      members     = ["davila97","maikol1995"]
      permission  = "pull"
    }

    "porv-common-devops" = {
      description = "Equipo de admin porv-common-devops"
      members     = [""]
      permission  = "admin"
    }
  }
}



module "repository_github" {
  source = "./devops-terra-repo-v2"
  //teams            = module.teams_github.teams

  repositories = [
    "iac-terra-repository-back",
    "iac-terra-repository-back2",
    "iac-terra-repository-back3"

     
  ]

  branch_protections = [
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

  visibility       = "public"
  teams_permission = module.teams_github.team_permission
  template = {
    owner      = "laboratory-terra-github"
    repository = "devops-template-terra"
  }


  depends_on = [
    module.teams_github
  ]

}

