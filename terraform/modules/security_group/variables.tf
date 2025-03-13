variable "vpc_id" {
  description = "The ID of the VPC where the security groups will be created"
  type        = string
}

variable "owner" {
  description = "Owner tag for the security groups"
  type        = string
  default     = "guytamari"
}