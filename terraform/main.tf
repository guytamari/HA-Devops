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