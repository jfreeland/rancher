terraform {
  required_version = ">= 1.12.0"

  backend "remote" {
    organization = "eland"

    workspaces {
      name = "rancher"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.98.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.4"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
