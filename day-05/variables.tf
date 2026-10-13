variable "ny_vpc_name"{
    default ="my-test-vpc"
    type = string
}

variable "my_vpc_cidr" {
  default = "10.0.0.0/16"
  type = string
}


variable "my_public_subnet_1a_cidr" {
  default = "10.0.1.0/24"
  type = string
}

variable "my_private_subnet_1a_cidr" {
  default = "10.0.2.0/24"
  type = string
}

variable "my_ami_id" {
  default = "ami-097855b862d5b1eb2"
  type = string
}


variable "my_instance_type" {
  default = "t3.micro"
  type = string
}

variable "my_storage_gb" {
  default = 10
  type = number
}



