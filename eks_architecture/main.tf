provider "aws" {
  region = var.default_region
}

locals {
  org = "IIR"
  env = var.env
}

module "mern_vpc" {
  source   = "./modules/vpc"
  vpc_name = "${local.org}-${local.env}-${var.vpc_name}"
  vpc_cidr = var.vpc_cidr

  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  igw_name         = "${local.org}-${local.env}-${var.igw_name}"
  nat_eip_name     = "${local.org}-${local.env}-${var.nat_eip_name}"
  nat_gateway_name = "${local.org}-${local.env}-${var.nat_gateway_name}"
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
  source    = "./modules/security_groups"
  vpc_id    = module.mern_vpc.vpc_id
  cidr_ipv4 = var.cidr_ipv4
  sg_name   = "${local.org}-${local.env}-${var.sg_name}"
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
  security_group_ids   = [module.security_groups.basic_sg_id]
  iam_instance_profile = data.aws_iam_instance_profile.existing_profile.name
  root_volume_size     = var.root_volume_size
  root_volume_type     = var.root_volume_type
  instance_name        = "${local.org}-${local.env}-${var.instance_name}"

  depends_on = [
    module.mern_vpc,
    module.security_groups
  ]
}

###################################
# EKS and IAM deployment
###################################

module "iam" {
  source                        = "./modules/iam"
  cluster-name                  = var.cluster_name
  is_eks_role_enabled           = true
  is_eks_nodegroup_role_enabled = true
}

module "eks" {
  source = "./modules/eks"

  is-eks-cluster-enabled = true
  cluster-name           = "${local.org}-${local.env}-${var.cluster_name}"
  cluster-version        = var.cluster_version
  env                    = var.env

  endpoint-private-access = false
  endpoint-public-access  = true

  ondemand_instance_types = var.ondemand_instance_types
  spot_instance_types     = var.spot_instance_types

  desired_capacity_on_demand = var.desired_capacity_on_demand
  min_capacity_on_demand     = var.min_capacity_on_demand
  max_capacity_on_demand     = var.max_capacity_on_demand

  desired_capacity_spot = var.desired_capacity_spot
  min_capacity_spot     = var.min_capacity_spot
  max_capacity_spot     = var.max_capacity_spot

  addons = var.eks_addons

  public_subnet_ids  = module.mern_vpc.public_subnet_ids
  private_subnet_ids = module.mern_vpc.private_subnet_ids
  vpc_id             = module.mern_vpc.vpc_id

  eks_cluster_role_arn   = module.iam.eks_cluster_role_arn
  eks_nodegroup_role_arn = module.iam.eks_node_role_arn

  security_group_ids        = [module.security_groups.eks_cluster_sg_id]
  worker_security_group_ids = [module.security_groups.eks_worker_sg_id]

  depends_on = [
    module.mern_vpc,
    module.iam
  ]
}



# ECR Repositories
module "ecr_repo1" {
  source          = "./modules/ecr"
  repository_name = var.repository1_name
  tags_all = {
    Name = "ECR-REPO-1"
  }
}

module "ecr_repo2" {
  source          = "./modules/ecr"
  repository_name = var.repository2_name
  tags_all = {
    Name = "ECR-REPO-2"
  }
}