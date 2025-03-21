output "nginx_sg_id" {
  description = "The ID of the nginx security group"
  value       = aws_security_group.nginx_sg.id
}

output "elb_sg_id" {
  description = "The ID of the lb security group"
  value       = aws_security_group.elb_sg.id
}

