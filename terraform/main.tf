module "ec2" {
  source           = "./modules/ec2"
  ami_ubuntu       = var.ami_ubuntu
  instance_type    = var.instance_type
  owner            = var.owner
  nginx_sg_id      = module.security_groups.nginx_sg_id
  public_subnet_id = module.vpc.public_subnet_id
  vpc_id           = module.vpc.vpc_id
}
module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zone   = var.availability_zone
}

module "security_groups" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
  owner  = var.owner
}