########################
# Networking
########################

resource "aws_vpc" "lab" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "lab-vpc"
  }
}

resource "aws_internet_gateway" "lab" {
  vpc_id = aws_vpc.lab.id

  tags = {
    Name = "lab-igw"
  }
}

resource "aws_subnet" "lab" {                       # Note to future self: I want to configure ipv6 to future-proof networking 
  vpc_id                  = aws_vpc.lab.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "lab-subnet"
  }
}

resource "aws_route_table" "lab" {
  vpc_id = aws_vpc.lab.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab.id
  }

  tags = {
    Name = "lab-rt"
  }
}

resource "aws_route_table_association" "lab" {
  subnet_id      = aws_subnet.lab.id
  route_table_id = aws_route_table.lab.id
}

resource "aws_security_group" "ssh" {
  name        = "lab-ssh"
  description = "Allow SSH"
  vpc_id      = aws_vpc.lab.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_ingress_cidr]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
}
 
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.0.1.0/24"]
}


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lab-ssh"
  }
}

########################
# AMIs
########################

data "aws_ami" "controller" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

data "aws_ami" "rhel10" {
  most_recent = true
  owners      = ["309956199498"]

  filter {
    name   = "name"
    values = ["RHEL-10*"]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

########################
# Instances (modules)
########################

module "controller" {
  source          = "./modules/ec2-instance"
  ami             = data.aws_ami.controller.id
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.lab.id
  security_groups = [aws_security_group.ssh.id]
  cloud_init      = "${path.module}/cloud-init/controller.yml"
  ssh_pubkey_path = var.ansible_ssh_pubkey_path


  tags = {
    Name = "ansible-controller"
    Env  = "lab"
    Role = "controller"
  }
}


module "rhel10" {
  source          = "./modules/ec2-instance"
  ami             = data.aws_ami.rhel10.id
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.lab.id
  security_groups = [aws_security_group.ssh.id]
  cloud_init      = "${path.module}/cloud-init/rhel.yml"
  ssh_pubkey_path = var.ansible_ssh_pubkey_path


  tags = {
    Name = "rhel10-managed"
    Env  = "lab"
    Role = "managed"
  }
}

module "ubuntu" {
  source          = "./modules/ec2-instance"
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.lab.id
  security_groups = [aws_security_group.ssh.id]
  cloud_init      = "${path.module}/cloud-init/ubuntu.yml"
  ssh_pubkey_path = var.ansible_ssh_pubkey_path
 
  tags = {
    Name = "ubuntu-managed"
    Env  = "lab"
    Role = "managed"
  }
}

