terraform {
  required_providers {
    aws= {
        source = "hashicorp/aws"
        version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket = "tf-state-bucket-2026-13-10"
    encrypt = true
    region = "us-east-1"
    use_lockfile = true
    key = "stage/terraform.tfstate"
  }
}


provider "aws" {
  region = var.region
}

