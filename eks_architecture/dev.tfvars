vpc_name         = "mern_vpc"
default_region   = "us-east-1"
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
instance_type     = "t2.2xlarge"
root_volume_size  = 30
root_volume_type  = "gp2"
instance_name     = "Jump-EC2-Instance"
availability_zone = "us-east-1a"
sg_name           = "jump_sg"

# EKS Cluster Assignments
cluster_name    = "mern-eks-cluster"
cluster_version = "1.29"
env             = "dev"

# EKS Node Group Configuration
ondemand_instance_types = ["t3.medium", "t3.small"]
spot_instance_types     = ["t3.medium", "t3.small"]

desired_capacity_on_demand = 2
min_capacity_on_demand     = 1
max_capacity_on_demand     = 3

desired_capacity_spot = 1
min_capacity_spot     = 1
max_capacity_spot     = 2

# EKS Addons
eks_addons = [
  {
    name    = "vpc-cni"
    version = "v1.18.0-eksbuild.1"
  },
  {
    name    = "coredns"
    version = "v1.11.1-eksbuild.4"
  },
  {
    name    = "kube-proxy"
    version = "v1.29.0-eksbuild.2"
  },
  {
    name    = "aws-ebs-csi-driver"
    version = "v1.46.0-eksbuild.1"
  }
]

cidr_ipv4 = "49.37.181.223/32"