vpc_name = "mern_vpc"
default_region = "us-east-1"
vpc_cidr         = "10.10.0.0/16"
igw_name         = "mern_igw"
nat_eip_name     = "mern_nat_eip"
nat_gateway_name = "mern_nat-gateway"
private_subnets = {
  "private_subnet_1" = 0
  "private_subnet_2" = 1
  "private_subnet_3" = 2
}

public_subnets = {
  "public_subnet_1" = 0
  "public_subnet_2" = 1
  "public_subnet_3" = 2
}
# EC2 variable assignments
instance_type = "t2.2xlarge"
root_volume_size = 30
root_volume_type = "gp2"
instance_name = "Jump-EC2-Instance"
availability_zone = "us-east-1a"
sg_name = "jump_sg"

# EKS Cluster Assignments
