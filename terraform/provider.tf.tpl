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
    bucket         = ${BUCKET_NAME}
    key            = "terraform.tfstate"
    region         = local.region
    dynamodb_table = ${DYNAMODB_NAME}
    encrypt        = true
  }

  required_version = ">= 1.6.2"
}

provider "aws" {
  region = local.region
}
