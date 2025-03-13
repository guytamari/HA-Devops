output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_az1_id" {
  value = module.vpc.public_subnet_az1_id
}

output "public_subnet_az2_id" {
  value = module.vpc.public_subnet_az2_id
}

output "private_subnet_id" {
  value = module.vpc.private_subnet_id
}

output "nginx_sg_id" {
  value = module.security_groups.nginx_sg_id
}

output "elb_sg_id" {
  value = module.security_groups.elb_sg_id
}


output "ec2_instance_id" {
  value = module.ec2.ec2_instance_id
}

output "elb_url" {
  value = module.ec2.elb_url
}