provider "aws" {
  region = var.default_region
}

module "mern_vpc" {
  source   = "./modules/vpc"
  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr

  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  igw_name         = var.igw_name
  nat_eip_name     = var.nat_eip_name
  nat_gateway_name = var.nat_gateway_name
}

########################################
# Creating the Jump EC2 Instance
########################################
# Get latest Ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# An IAM instance profile would have already been created by previous Jenkins Architecture setup
# Use a data block to lookup it's ID
data "aws_iam_instance_profile" "existing_profile" {
  name = "EC2-ADMIN-ACCESS-PROFILE"
}

# Calling the security groups module
module "security_groups" {
  source  = "./modules/security_groups"
  vpc_id  = module.mern_vpc.vpc_id
  sg_name = var.sg_name
}

# Calling the EC2 Module
module "jump_ec2" {
  source               = "./modules/ec2"
  ami_id               = data.aws_ami.ubuntu.id
  vpc_id               = module.mern_vpc.vpc_id
  instance_type        = var.instance_type
  subnet_id            = module.mern_vpc.public_subnet_ids[0]
  availability_zone    = var.availability_zone
  user_data            = file("modules/ec2/jump_setup.sh")
  security_group_ids   = [module.security_groups.basic_sg_id] # Make sure to add the output to take it as input here
  iam_instance_profile = data.aws_iam_instance_profile.existing_profile.name
  root_volume_size     = var.root_volume_size
  root_volume_type     = var.root_volume_type
  instance_name        = var.instance_name

  depends_on = [
    module.mern_vpc,
    module.security_groups
  ]
}

###################################
# EKS and IAM deployment
###################################

locals {
  org = "mern-stack-org"
  env = var.env
}

module "iam" {
  source                          = "./modules/iam"
  cluster-name                    = var.cluster_name
  is_eks_role_enabled             = true
  is_eks_nodegroup_role_enabled   = true
}

module "eks" {
  source = "./modules/eks"

  is-eks-cluster-enabled = true
  cluster-name           = var.cluster_name
  cluster-version        = var.cluster_version
  env                    = var.env

  endpoint-private-access = false
  endpoint-public-access  = true

  ondemand_instance_types      = var.ondemand_instance_types
  spot_instance_types          = var.spot_instance_types

  desired_capacity_on_demand = var.desired_capacity_on_demand
  min_capacity_on_demand     = var.min_capacity_on_demand
  max_capacity_on_demand     = var.max_capacity_on_demand

  desired_capacity_spot = var.desired_capacity_spot
  min_capacity_spot     = var.min_capacity_spot
  max_capacity_spot     = var.max_capacity_spot

  addons = var.eks_addons

  public_subnet_ids = data.terraform_remote_state.vpc.outputs.public_subnet_ids

  eks_cluster_role_arn     = module.iam.eks_cluster_role_arn
  eks_nodegroup_role_arn   = module.iam.eks_node_role_arn
}
