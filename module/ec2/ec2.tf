# Network Interface
resource "aws_instance" "myec2" {
    ami = "ami-0031d539e05f0ee86"
    instance_type = "t2.micro"
    # availability_zone = var.availability_zone[0]
    subnet_id = var.public_subnet_id
    associate_public_ip_address = true
}
