terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.21"
    }
  }

  # local backend. Not required if you run setup first
  # to create remote backend

  # backend "local" {
  #   path = ".tfstate"
  # }

  # s3 remote backend
  backend "s3" {
    bucket         = "terraform-remote-state-<YOUR_ACCOUNT_ID>"
    key            = "terraform.tfstate"
    region         = local.region
    dynamodb_table = "terraform-remote-state-lock"
    encrypt        = true
  }

  required_version = ">= 1.6.2"
}

provider "aws" {
  region = local.region
}
