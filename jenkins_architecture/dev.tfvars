# Security Groups tfvars
cidr_ipv4 = "223.237.167.50/32"


# IAM tfvars
role_name = "EC2-ADMIN-ACCESS"
policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
ec2_profile_name = "EC2-ADMIN-ACCESS-PROFILE"

# Jenkins tfvars
env = "dev"
availability_zone = "us-east-1a"
instance_type = "t2.2xlarge"
root_volume_size = 30
root_volume_type = "gp2"
instance_name = "Jenkins-Instance"
