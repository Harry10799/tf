terraform {
    backend "s3"{
        bucket ="tf-state-bucket-2026-10-13"
        key = "terraform/terraform.tfstate"
        encrypt = true
        use_lockfile = true
        region = "us-east-1"
    }
}