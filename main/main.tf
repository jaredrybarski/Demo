
module "networking" {
  source    = "../modules/networking"
  namespace = var.namespace
}


module "ec2" {
  source     = "../modules/ec2"
  namespace  = var.namespace
  vpc        = module.networking.vpc_id
  sg_pub_id  = module.networking.sg_pub_id
  sg_priv_id = module.networking.sg_pub_id
  private_subnets = module.networking.private_subnet
  public_subnets = module.networking.public_subnet
  key_name = "mainc"
  
}

