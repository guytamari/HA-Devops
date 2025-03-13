variable "owner" {
  description = "Owner tag for the ec2"
  type        = string
  default     = "guytamari"
}

variable "instance_type" {
    description = "instance type to be used"
    type = string
}

variable "ami_ubuntu" {
    description = "ami id for the ec2 - ubuntu 22.04"
    type = string
}

variable "nginx_sg_id" {
  description = "SG id for the ec2"
  type        = string
}

variable "public_subnet_id" {
  description = "public subnet id for ec2"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the vpc"
  type        = string
}