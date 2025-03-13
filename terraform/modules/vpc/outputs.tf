output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_az1_id" {
  description = "The ID of the public subnet az1"
  value       = aws_subnet.public_az1.id
}

output "public_subnet_az2_id" {
  description = "The ID of the public subnet az2"
  value       = aws_subnet.public_az2.id
}

output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = aws_subnet.private.id
}
