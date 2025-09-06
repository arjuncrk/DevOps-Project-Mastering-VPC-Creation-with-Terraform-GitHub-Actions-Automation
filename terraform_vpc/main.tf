module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  subnet_cidr = var.subnet_cidr
}

module "sg" {
  source = "./modules/sg"
  vcp_id = module.vpc.vpc_id
}


module "ec2" {
  source = "./modules/ec2"
  sg_id = module.sg.sg_id   # she is using module.vpc.sg_id
  subnets = module.vpc.subnet_ids
}
# module vpc jo "./modules/vpc" is path me hai usko call kar ke thum neeche wala value pass karo


module "alb" {
  source =  "./modules/alb"
  sg_id  = module.sg.sg_id
  subnets = module.vpc.subnet_ids
  vcp_id = module.vpc.vpc_id
  instances = module.ec2.instances
}
