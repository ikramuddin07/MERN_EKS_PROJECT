provider "aws" {
  region = "us-east-1" # or your desired region
}

# Get default VPC
data "aws_vpc" "default" {
  default = true
}

# Get all subnets in default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

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

# Calling the security groups module
module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = data.aws_vpc.default.id
}

# Calling the IAM Roles Module
module "ec2_admin_iam_role" {
  source     = "./modules/iam"
  role_name  = "EC2-ADMIN-ACCESS"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Before EC2 can use IAM role, the resource must be created first
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "EC2-ADMIN-ACCESS-PROFILE"
  role = module.ec2_admin_iam_role.role_name
}


# Create Jenkins EC2 instance using module
module "jenkins_instance" {
  source               = "./modules/ec2"
  ami_id               = data.aws_ami.ubuntu.id
  availability_zone    = "us-east-1a"
  instance_type        = "t2.2xlarge"
  root_volume_size     = 30
  root_volume_type     = "gp2"
  subnet_id            = data.aws_subnets.default.ids[0]
  instance_name        = "Jenkins-Instance"
  user_data            = file("modules/ec2/jenkins_setup.sh")
  vpc_id               = data.aws_vpc.default.id
  security_group_ids   = [module.security_groups.jenkins_sg_id]
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
}