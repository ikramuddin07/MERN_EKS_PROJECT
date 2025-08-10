##########################
# Security Groups
##########################
##########################
# Basic Security Group
##########################
# Inbound Rules
resource "aws_security_group" "basic_sg" {
  name   = "Allow HTTP aND HTTPS"
  vpc_id = var.vpc_id

  tags = {
    Name = var.sg_name
  }
}
resource "aws_vpc_security_group_ingress_rule" "basic_http" {
  security_group_id = aws_security_group.basic_sg.id
  cidr_ipv4         = var.cidr_ipv4
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  description       = "Allow HTTP"
}

resource "aws_vpc_security_group_ingress_rule" "basic_https" {
  security_group_id = aws_security_group.basic_sg.id
  cidr_ipv4         = var.cidr_ipv4
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  description       = "Allow HTTPS"
}

# Outbound (Allow all traffic to leave)
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.basic_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  description       = "Allow all outbound traffic"
}

#####################################
# EKS Cluster Access Security Group
#####################################

# Allow access to Cluster through HTTPS 443 through Jump Server Only
resource "aws_security_group" "eks_cluster_sg" {
  name   = "Allow access to cluster HTTPS 443 through Jump Server Only"
  vpc_id = var.vpc_id

  tags = {
    Name = var.sg_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "eks_https" {
  security_group_id = aws_security_group.eks_cluster_sg.id
  cidr_ipv4         = var.cidr_ipv4
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  description       = "Allow HTTPS"
}

resource "aws_vpc_security_group_egress_rule" "eks_allow_all" {
  security_group_id = aws_security_group.eks_cluster_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  description       = "Allow all traffic to leave"
}

#####################################
# EKS Worker Node Security Group
#####################################

resource "aws_security_group" "eks_worker_sg" {
  name   = "EKS Worker Node Security Group"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.sg_name}-worker"
  }
}

# Allow all traffic within the security group (node-to-node communication)
resource "aws_vpc_security_group_ingress_rule" "worker_self" {
  security_group_id            = aws_security_group.eks_worker_sg.id
  referenced_security_group_id = aws_security_group.eks_worker_sg.id
  ip_protocol                  = "-1"
  description                  = "Allow all traffic within the worker node security group"
}

# Allow worker nodes to communicate with cluster API server
resource "aws_vpc_security_group_ingress_rule" "worker_to_cluster" {
  security_group_id            = aws_security_group.eks_worker_sg.id
  referenced_security_group_id = aws_security_group.eks_cluster_sg.id
  from_port                    = 443
  to_port                      = 443
  ip_protocol                  = "tcp"
  description                  = "Allow worker nodes to communicate with cluster API server"
}

# Allow cluster API server to communicate with worker nodes
resource "aws_vpc_security_group_ingress_rule" "cluster_to_worker" {
  security_group_id            = aws_security_group.eks_worker_sg.id
  referenced_security_group_id = aws_security_group.eks_cluster_sg.id
  from_port                    = 1025
  to_port                      = 65535
  ip_protocol                  = "tcp"
  description                  = "Allow cluster API server to communicate with worker nodes"
}

# Allow worker nodes to communicate with each other
resource "aws_vpc_security_group_ingress_rule" "worker_to_worker" {
  security_group_id            = aws_security_group.eks_worker_sg.id
  referenced_security_group_id = aws_security_group.eks_worker_sg.id
  from_port                    = 1025
  to_port                      = 65535
  ip_protocol                  = "tcp"
  description                  = "Allow worker nodes to communicate with each other"
}

# Allow outbound traffic from worker nodes
resource "aws_vpc_security_group_egress_rule" "worker_egress" {
  security_group_id = aws_security_group.eks_worker_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  description       = "Allow all outbound traffic from worker nodes"
}