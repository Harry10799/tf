output "my_ec2_dns" {
  value = aws_instance.my_aws_vm.private_ip
}