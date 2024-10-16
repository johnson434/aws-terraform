variable "ami" {
    type = string
    description = "EC2가 사용한 Machine Image"
}

variable "tier" {
    type = string
    description = "EC2가 사용할 EC2 등급"
}

variable "public_subnet_id" {
    type = string
    description = "퍼블릭 서브넷 아이디"
}

variable "availability_zone" {
    type = list(string)
    description = "EC2가 생성될 AZ"
    default = ["ap-northeast-2a", "ap-northeast-2c"]
}


# Network Interface
resource "aws_network_interface" "pni" {
    subnet_id = var.public_subnet_id
    private_ips = ["10.0.10.100"]

    tags = {
        Name = "pni"
    }
}

resource "aws_instance" "myec2" {
    ami = "ami-0031d539e05f0ee86"
    instance_type = "t2.micro"
    availability_zone = var.availability_zone[0]

    network_interface {
        network_interface_id = aws_network_interface.pni.id
        device_index = 0
    }
}
