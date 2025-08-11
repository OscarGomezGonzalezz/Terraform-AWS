#EXPLANATION:
#we set the backend remotely into the terraform cloud platform, but we also define that 
# our resources are gonna be provided by aws

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