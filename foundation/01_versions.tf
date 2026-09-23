# terraform block
terraform {
    required_version =">=1.0.0"
    required_providers {
        aws ={
            source = "hashicorp/aws"
            version = "6.14.1"
        }
        random = {
            source ="hashicorp/random"
            version = "3.9.1"
        }
    }
}

# Provider block

provider "aws" {
    region = "us-east-1"
}
