provider "aws" {
    region = "ap-northeast-2"
}

# VPC
resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"

    tags = {
        Name = "main"
    }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

# Route Table
resource "aws_route_table" "public-route-table" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    route {
        cidr_block = "10.0.0.0/16"
        gateway_id = "local"
    }
}

resource "aws_route_table" "private-route-table" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "10.0.0.0/16"
        gateway_id = "local"
    }
}


# Subnet
resource "aws_subnet" "public-a" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.10.0/24"
    availability_zone = "ap-northeast-2a"

    tags = {
        Name = "public-subnet"
    }
} 

resource "aws_subnet" "private-a" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.20.0/24"
    availability_zone = "ap-northeast-2c"

    tags = {
        Name = "private-subnet"
    }
}

# Network Interface
resource "aws_network_interface" "pni" {
    subnet_id = aws_subnet.public-a.id
    private_ips = ["10.0.10.100"]

    tags = {
        Name = "pni"
    }
}

# EC2 
resource "aws_instance" "myec2" {
    ami = "ami-0031d539e05f0ee86"
    instance_type = "t2.micro"
    availability_zone = "ap-northeast-2a"

    network_interface {
        network_interface_id = aws_network_interface.pni.id
        device_index = 0
    }
}
