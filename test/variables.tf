variable "my_vpc" {
  default = "my-test-vpc"
  type = string
}


variable "my_vpc_cidr" {
  default = "10.0.0.0/16"
  type = string
}

variable "my_pb_cidr" {
  default = "10.0.1.0/24"
  type = string
}

variable "my_pvt_cidr" {
  default = "10.0.2.0/24"
  type = string
}
