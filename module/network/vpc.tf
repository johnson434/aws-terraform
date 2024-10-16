variable "vpc_cidr_block" {
    description = "vpc cidr block"
    type = string
    default = "10.0.0.0/24"
}

# VPC
resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr_block
    tags = {
        name = "default_vpc"
    }
}

# IGW
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
resource "aws_subnet" "public_a" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.10.0/24"
    availability_zone = "ap-northeast-2a"

    tags = {
        Name = "public_subnet"
    }
} 

resource "aws_subnet" "private_a" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.20.0/24"
    availability_zone = "ap-northeast-2c"

    tags = {
        Name = "private_subnet"
    }
}

# output
output "public_subnet_id" {
    value = aws_subnet.public_a.id
}
