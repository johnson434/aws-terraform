variable "region" {
    description = "서비스가 제공될 지역"
    type = string
    default = "ap-northeast-2"
}

provider "aws" {
    region = var.region
}

module "network" {
    source = "./module/network"
    vpc_cidr_block = "10.0.0.0/16"
}

module "ec2" {
    source = "./module/ec2"
    ami = "ami-0031d539e05f0ee86"
    tier = "t2.micro"
    public_subnet_id = module.network.public_subnet_id
    availability_zone = ["ap-northeast-2a", "ap-northeast-2c"]
}

