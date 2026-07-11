module "network" {
  source = "./modules/network"

  cidr_block          = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
}

module "security" {
  source = "./modules/security"

  vpc_id = module.network.vpc_id
}

module "compute" {
  source = "./modules/compute"

  ami = "ami-0c02fb55956c7d316"  # Amazon Linux 2 (us-east-1)

  public_subnet_id  = module.network.public_subnet_id
  private_subnet_id = module.network.private_subnet_id

  web_sg_id = module.security.web_sg_id
  app_sg_id = module.security.app_sg_id

  instance_profile_name = module.security.instance_profile_name
}

module "monitoring" {
  source = "./modules/monitoring"

  web_instance_id = module.compute.web_instance_id
  alert_email = "jakiya1188@gmail.com"
}


