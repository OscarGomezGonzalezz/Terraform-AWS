#EXPLANATION:
#When we talk about remote or local backend, it means where the terraform state file is hosted . So although in the first part of
#the bootstrapping we are deploying resources at aws(remotely), the backend is still local, because the state file is not mounted yet
#at the s3 bucket.

terraform {
  #############################################################
  ## AFTER RUNNING TERRAFORM APPLY (WITH LOCAL BACKEND)
  ## YOU WILL UNCOMMENT THIS CODE THEN RERUN TERRAFORM INIT
  ## TO SWITCH FROM LOCAL BACKEND TO REMOTE AWS BACKEND
  #############################################################
  # backend "s3" {
  #   bucket         = "devops-directive-tf-state" # REPLACE WITH YOUR BUCKET NAME
  #   key            = "03-basics/import-bootstrap/terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "terraform-state-locking" #this db offers atomicy so that there are no overwrittings between diff devs
  #   encrypt        = true
  # }

  #IF WE DONT DISCOMMENT THE CODE ABOVE, THE BACKEND WILL REMAIN LOCAL
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# the state file will live into the s3 bucket
resource "aws_s3_bucket" "terraform_state" {
  bucket        = "personal-bucket923847" # REPLACE WITH YOUR BUCKET NAME (ONLY LOWER CASE)
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "terraform_bucket_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_crypto_conf" {
  bucket        = aws_s3_bucket.terraform_state.bucket 
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-state-locking"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}