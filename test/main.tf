resource "aws_vpc" "my_test_vpc" {
  cidr_block = var.my_vpc_cidr
  tags = {
    "Name" = var.my_vpc
  }
}

resource "aws_subnet" "my_public_subnet" {
  vpc_id = aws_vpc.my_test_vpc.id
  cidr_block = var.my_pb_cidr
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "My-public-subnet"
  }
}

resource "aws_subnet" "my_private_subnet" {
  vpc_id = aws_vpc.my_test_vpc.id
  cidr_block = var.my_pvt_cidr
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "My-private-subnet"
  }
}


resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_test_vpc.id
  tags = {
    "Name" = "my_igw"
  }
}

resource "aws_route_table" "my_pub_rt" {
  vpc_id = aws_vpc.my_test_vpc.id
  route {
    gateway_id = aws_internet_gateway.my_igw.id
    cidr_block = "0.0.0.0/0"
  }
  tags = {
    "Name" = "my_pb_rt"
  }
}


resource "aws_route_table" "my_pvt_rt" {
  vpc_id = aws_vpc.my_test_vpc.id
  tags = {
    "Name" = "my_pvt_rt"
  }
}


resource "aws_route_table_association" "my_pb_rt_ass" {
  route_table_id = aws_route_table.my_pub_rt.id
  subnet_id = aws_subnet.my_public_subnet.id 
}


resource "aws_route_table_association" "my_pvt_rt_ass" {
  route_table_id = aws_route_table.my_pvt_rt.id
  subnet_id = aws_subnet.my_private_subnet.id 
}


resource "aws_security_group" "my_sg" {
  vpc_id = aws_vpc.my_test_vpc.id
  name = "MY_SG"

  ingress {
    from_port = 22
    to_port = 22
    description = "for ssh"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port =80
    to_port = 80
    description = "for http"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    description = "all traffic"
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "-1"
  }
}




resource "aws_instance" "my_aws_vm" {
  ami = "ami-04b938437b69a2c9c"
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  instance_type = "t3.micro"
  subnet_id = aws_subnet.my_public_subnet.id
  root_block_device {
    volume_size = "8"
    volume_type = "gp3"
  }
  associate_public_ip_address = true
  user_data = file("install.sh")
  tags = {
    "Name" = "My_VM"
  }
}