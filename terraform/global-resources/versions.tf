terraform {
  required_providers {
    auth0 = {
      source  = "alexkappa/auth0"
      version = ">= 0.2.1"
    }
    aws = {
      source = "hashicorp/aws"
    }
    external = {
      source = "hashicorp/external"
    }
    http = {
      source = "hashicorp/http"
    }
  }
  required_version = ">= 0.14"
}
