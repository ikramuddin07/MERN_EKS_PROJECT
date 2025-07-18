provider "aws" {
  region = var.default_region
}

module "MERN_VPC_infra" {
  source         = "./modules/VPC_Infra"
  MERN_VPC_CIDR  = var.MERN_VPC_CIDR
  default_region = var.default_region

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

# This should reside in the default VPC and in any subnet
module "jenkins_instance" {
  source        = "./modules/ec2_instance"
  ami_id        = data.aws_ami.ubuntu.id
  vpc_id        = data.aws_vpc.default.id
  instance_type = "t2.2xlarge"
  root_volume_size = 30
  root_volume_type = "gp3"
  subnet_id     = data.aws_subnet_ids.default.ids[0] 
  instance_name = "Jenkins-Instance"
  user_data = file("modules/ec2/jenkins_setup.sh")
}

# This should reside in the public subnet of the newly created VPC.
module "jump_ec2_instance" {
  source        = "./modules/ec2_instance"
  ami_id        = var.ami_id
  instance_type = "t2.2xlarge"
  instance_name = "Jump-EC2-Instance"
  subnet_id     = module.MERN_VPC_infra.public_subnet_ids[1]
  root_volume_size = 30
  root_volume_type = "gp3"
  vpc_id        = module.MERN_VPC_infra.vpc_id
  user_data = file("modules/ec2/jump_ec2_setup.sh")
}