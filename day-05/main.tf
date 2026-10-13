resource "aws_vpc" "my_vpc_main" {
  cidr_block = var.my_vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    "Name" = var.ny_vpc_name
  }
}

# resource "aws_key_pair" "my_key_pair" {
#   key_name = 
# }

resource "aws_subnet" "my_public_subnet" {
  cidr_block = var.my_public_subnet_1a_cidr
  vpc_id = aws_vpc.my_vpc_main.id
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "My-Public-subent"
  }
}

resource "aws_subnet" "my_private_subnet" {
  cidr_block = var.my_private_subnet_1a_cidr
  vpc_id = aws_vpc.my_vpc_main.id
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "My-Private-subent"
  }
}


resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc_main.id
  tags = {
    "Name" = "My_IGW"
  }
}



resource "aws_route_table" "my_public_rt" {
  vpc_id = aws_vpc.my_vpc_main.id
  route {
    gateway_id = aws_internet_gateway.my_igw.id
    cidr_block = "0.0.0.0/0"
  }
  tags = {
    "Name" = "My-RT-Public"
  }
}

resource "aws_route_table" "my_private_rt" {
  vpc_id = aws_vpc.my_vpc_main.id
  tags = {
    "Name" = "My-RT-Private"
  }
}


resource "aws_route_table_association" "my_rt_ass" {
  route_table_id = aws_route_table.my_public_rt.id
  subnet_id = aws_subnet.my_public_subnet.id
}


resource "aws_security_group" "aws_security_grp" {
  vpc_id = aws_vpc.my_vpc_main.id
  name = "My-SG"

  ingress {
    from_port = 22
    to_port = 22
    description = "allow ssh port"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    description = "allow http"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    description = "allow internet traffic"
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "-1"
  }
}


resource "aws_instance" "my_ec2_vm" {
  vpc_security_group_ids = [aws_security_group.aws_security_grp.id]
  subnet_id = aws_subnet.my_public_subnet.id
  ami = var.my_ami_id
  instance_type = var.my_instance_type
  root_block_device {
    volume_size = var.my_storage_gb
    volume_type = "gp3"
  }
  user_data = file("install_nginx.sh")
  associate_public_ip_address = true
  tags = {
    "Name" = "My-ec2-vm"
  }
}

resource "aws_lb" "my_lb" {
  name = "my-http-lb"
  load_balancer_type = "application"
  internal = false
  security_groups = [aws_security_group.aws_security_grp.id]
  subnets = [aws_subnet.my_public_subnet.id]
}


resource "aws_lb_target_group" "my_lb-grup" {
  name = "my-tg-grup"
  vpc_id = aws_vpc.my_vpc_main.id
  protocol = "HTTP"
  port = 80
}

resource "aws_lb_listener" "my_lb_lg" {
    load_balancer_arn = aws_lb.my_lb.arn
    port = 80
    protocol = "HTTP"
    default_action {
          target_group_arn = aws_lb_target_group.my_lb-grup.arn
            type = "forward"
    }
}