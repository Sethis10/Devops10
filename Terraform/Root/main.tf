module "vpc" {
  source = "../Modules/vpc"
  project_name = var.project_name
  vpc_cidr = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

module "nat" {
  source = "../Modules/nat"
  vpc_id = module.vpc.vpc_id
  igw_id = module.vpc.igw_id
  public_subnet_id = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
}

module "ec2" {
  source = "../Modules/ec2"
  private_subnet_id = module.vpc.private_subnet_id
  public_subnet_id = module.vpc.public_subnet_id
  ami   = var.ami
  key   = var.key
  vpc_id = module.vpc.vpc_id
  
}