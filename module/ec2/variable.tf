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
