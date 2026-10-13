terraform{
    required_providers {
      aws= {
        source = "hashicorp/aws"
        version = "~> 6.0"
      }
    }

    backend "s3" {
      bucket = "tf-state-bucket-2026-13-10"
      use_lockfile = true
      region = "us-east-1"
      encrypt = true
      key = "dev/terraform.tfstate"
    }
}


provider "aws" {
  region = "us-east-1"
}



