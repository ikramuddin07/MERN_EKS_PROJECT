##########################
# Security Groups
##########################
##########################
# Basic Security Group
##########################
# Inbound Rules
resource "aws_security_group" "basic_sg" {
  name = "Allow HTTP aND HTTPS"
  vpc_id = var.vpc_id

  tags = {
    Name = var.sg_name
  }
}
resource "aws_vpc_security_group_ingress_rule" "basic_http" {
  security_group_id = aws_security_group.basic_sg.id
  cidr_ipv4         = "49.37.179.251/32"
  #cidr_ipv4 = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  description       = "Allow HTTP"
}

resource "aws_vpc_security_group_ingress_rule" "basic_https" {
  security_group_id = aws_security_group.basic_sg.id
  cidr_ipv4         = "49.37.179.251/32"
  #cidr_ipv4 = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  description       = "Allow HTTPS"
}

# Outbound (Allow all traffic to leave)
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.basic_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
  description = "Allow all outbound traffic"
}

#####################################
# EKS Cluster Access Security Group
#####################################

# Allow access to Cluster 443 through Jump Server Only
resource "aws_security_group" "eks_cluster_sg" {
  name = "Allow access to cluster HTTPS 443 through Jump Server Only"
  vpc_id = var.vpc_id

  tags = {
    Name = var.sg_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "eks_https" {
  security_group_id = aws_security_group.eks_cluster_sg.id
  cidr_ipv4 = "49.37.179.251/32"
  from_port = 443
  to_port = 443
  ip_protocol = "tcp"
  description = "Allow HTTPS"
}

resource "aws_vpc_security_group_egress_rule" "eks_allow_all" {
  security_group_id = aws_security_group.eks_cluster_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
  description = "Allow all traffic to leave"
}