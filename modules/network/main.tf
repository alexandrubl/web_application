module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.cidr

  azs             = var.azs
  public_subnets  = var.pub_subnets   
  private_subnets = var.priv_subnets

  enable_nat_gateway = false
  enable_vpn_gateway = false

  
  tags = {
    Name = "dev"
  }

  igw_tags = {
    Name = "IGW"
  }

  public_subnet_tags = {
    Name = "pub_subnets"
  }

  private_subnet_tags = {
    Name = "priv_subnets"
  }
}


