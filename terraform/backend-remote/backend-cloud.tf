terraform {
  backend "remote" {
    organization = "Personal-Organization923847"

    workspaces {
      name = "introduction"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  #aws credentials are automatically obtained by terraform from the .pkg file created after executing aws configure
}