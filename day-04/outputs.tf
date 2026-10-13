output "my_vpc_cidr" {
  value = aws_vpc.my_vpc.cidr_block
}