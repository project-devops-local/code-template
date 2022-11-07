terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "4.29.0"
    }
  }
  
  /*
  backend "azurerm" {
    resource_group_name  = "storage"
    storage_account_name = "pruebastorage01"
    container_name       = "estados"
    key                  = "prueba.tfstate"
    access_key           = "TOKEN"
  }*/

}
