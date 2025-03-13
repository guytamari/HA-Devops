output "ec2_instance_id" {
  value = aws_instance.nginx.id
}

output "elb_url" {
  value = aws_lb.nginx_lb.dns_name
}