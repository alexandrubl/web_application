terraform {
    required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.9"
    }
  }

}

provider aws {
    profile = "default"
    region  = "us-east-1"
}

# =====Create VPC and subnets=====

module "network" {
  source = "./modules/network"

  azs          = var.azs
  cidr         = var.cidr
  vpc_name     = var.vpc_name
  pub_subnets  = var.pub_subnets
  priv_subnets = var.priv_subnets
#  availability_zones = var.azs
#  cidr_block         = var.cidr
}

# =====Create SG =====

module "security" {
  source = "./modules/security"

  vpc_id         = module.network.vpc_id
  pub_subnets    = var.pub_subnets

  depends_on = [
    module.network
  ]
}

# =====Create bastion host====

#module "bastion" {
#  source = "./modules/bastion"

  #instance_type = "t2.micro"
#  key_name      = var.key_name
#  subnet_id     = module.network.public_subnets[0]
#  sg_id         = module.security.bastion_sg_id
 #  bastion_sg_id         = module.security.database_sg_id

#  depends_on = [
#    module.network,
#    module.security
#  ]
#}

# =====Create database=====

#module "storage" {
#  source = "./modules/storage"

# # instance_type = "t2.micro"
#  key_name      = var.key_name
#  subnet_id     = module.network.private_subnets[0]
#  sg_id         = module.security.database_sg_id

#  depends_on = [
#    module.network,
#    module.security
#  ]
#}

# =====Create application instance=====

module "application" {
  source = "./modules/application"

  instance_type   = "t2.micro"
  key_name        = var.key_name
  vpc_id          = module.network.vpc_id
  public_subnets  = module.network.public_subnets
  private_subnets = module.network.private_subnets
  webserver_sg_id = module.security.container_sg_id
  alb_sg_id       = module.security.alb_sg_id
#  mongodb_ip      = module.storage.db_private_ip

  depends_on = [
    module.network,
    module.security,
#    module.storage
  ]
}

#===== Create Cluster =====


module "ecs_cluster" {
  source = "./modules/ecs_cluster"

  ecs_name = var.ecs_name
}
