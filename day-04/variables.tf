variable "region" {
  default = "us-east-1"
  type = string
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
  type = string
}

variable "vpc_name" {
  default = "MY-DEV-VPC"
  type = string
}

variable "environment" {
  default = "stage"
  type = string
}