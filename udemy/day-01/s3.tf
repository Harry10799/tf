terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 6.0"
    }
    random = {
        source = "hashicorp/random"
        version = "~> 3.0"
    }
  }
}


provider "aws" {
  region = "us-east-1"
}

resource "random_id" "bucket_suffix" {
  byte_length = 6
}


resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-bucket-${random_id.bucket_suffix.hex}"
}


output "aws_bucket_bucket" {
  value = aws_s3_bucket.my_bucket.bucket
}