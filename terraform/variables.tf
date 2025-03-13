variable "region" {
  description = "AWS region to deploy"
  type        = string
  default     = "us-east-1"
}
variable "availability_zone" {
  description = "The availability zone to deploy"
  type        = string
  default     = "us-east-1a"
}

variable "vpc_cidr" {
  description = "CIDR range for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR range for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR range for the private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "owner" {
  description = "Owner tag for the resources"
  type        = string
  default     = "guytamari"
}

variable "instance_type" {
  description = "instance type to be used"
  type        = string
  default     = "t2.micro"
}

variable "ami_ubuntu" {
  description = "ami id for the ec2 - ubuntu 22.04"
  type        = string
  default     = "ami-0e1bed4f06a3b463d"
}
