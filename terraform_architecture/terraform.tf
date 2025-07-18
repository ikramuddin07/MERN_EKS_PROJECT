terraform {
  required_version = "~1.12.1"

  cloud {
    organization = "ikramuddin-terraform-cloud-personal"
    workspaces {
      name = "mern_aws_infra"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.3.0"
    }
  }
}