module "ec2" {
  source           = "./modules/ec2"
  ami_ubuntu       = var.ami_ubuntu
  instance_type    = var.instance_type
  owner            = var.owner
  nginx_sg_id      = module.security_groups.nginx_sg_id
  elb_sg_id        = module.security_groups.elb_sg_id
  public_subnet_id = [module.vpc.public_subnet_az1_id,module.vpc.public_subnet_az2_id]
  private_subnet_id = module.vpc.private_subnet_id
  vpc_id           = module.vpc.vpc_id
  key_pair_name    = var.key_pair_name
}
module "vpc" {
  source                 = "./modules/vpc"
  vpc_cidr               = var.vpc_cidr
  public_subnet_cidr     = var.public_subnet_cidr
  public_subnet_cidr_az2 = var.public_subnet_cidr_az2
  private_subnet_cidr    = var.private_subnet_cidr
  availability_zones     = var.availability_zones
}

module "security_groups" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
  owner  = var.owner
}