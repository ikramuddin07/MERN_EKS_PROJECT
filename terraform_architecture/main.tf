provider "aws" {
  region = var.default_region
}

module "MERN_VPC_infra" {
  source           = "./modules/VPC_Infra"
  MERN_VPC_CIDR    = var.MERN_VPC_CIDR
  default_region   = var.default_region

  public_subnets = {
    "public_subnet_1" = 0
    "public_subnet_2" = 1
    "public_subnet_3" = 2
  }

  private_subnets = {
    "private_subnet_1" = 0
    "private_subnet_2" = 1
    "private_subnet_3" = 2
  }
}

module "default_ec2_instance" {
  source         = "./modules/ec2_instance"
  ami_id         = var.ami_id
  instance_type  = var.instance_type
  instance_name  = "Default-EC2-Instance"
}