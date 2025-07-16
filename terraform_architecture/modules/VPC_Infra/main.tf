# This is the main VPC Infrastructure, It consists of:
#1. VPC
#2. Subnets (3 Public, 3 Private) Spread across multiple AZ's
#3. Route tables and route tables association
#4. Internet Gateway and NAT Gateway

# Define the project's VPC
resource "aws_vpc" "MERN_VPC" {
  cidr_block = var.MERN_VPC_CIDR
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "MERN_VPC"
  }
}

# Get all available AZs in the region
data "aws_availability_zones" "available" {}

# Deploying Private Subnets
resource "aws_subnet" "private_subnets" {
  for_each = var.private_subnets
  vpc_id = aws_vpc.MERN_VPC.id
  cidr_block        = cidrsubnet(var.MERN_VPC_CIDR, 8, each.value)
  availability_zone = data.aws_availability_zones.available.names[each.value]
  tags = {
    Name      = each.key
    Terraform = "true"
  }
}

# Deploying Public Subnets
resource "aws_subnet" "public_subnets" {
  for_each = var.public_subnets
  vpc_id = aws_vpc.MERN_VPC.id
  cidr_block        = cidrsubnet(var.MERN_VPC_CIDR, 8, each.value + 100)
  availability_zone = data.aws_availability_zones.available.names[each.value]
  map_public_ip_on_launch = true
  tags = {
    Name      = each.key
    Terraform = "true"
  }
}

# Create a route table for private subnets
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.MERN_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.MERN_NAT.id
  }
  tags = {
    Name = "Private-RT"
    Terraform = "true"
  }
}

# Create a route table for public subnets
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.MERN_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.MERN_IGW.id
  }
  tags = {
    Name = "Public-RT"
    Terraform = "true"
  }
}

# Create a route table association for private subnets
resource "aws_route_table_association" "private" {
  for_each       = aws_subnet.private_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_route_table.id
}

# Create a route table association for public subnets
resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_route_table.id
}

# Deploying an Internet Gateway
resource "aws_internet_gateway" "MERN_IGW" {
  vpc_id = aws_vpc.MERN_VPC.id
  tags = {
    Name = "MERN_IGW"
  }
}

# Create an Elastic IP for NAT Gateway
resource "aws_eip" "MERN_NAT_EIP" {
  domain = "vpc"
  depends_on = [aws_internet_gateway.MERN_IGW]
  tags = {
    Name = "MERN_NAT_EIP"
  }
}

# Deploying a NAT Gateway (in the first public subnet)
resource "aws_nat_gateway" "MERN_NAT" {
  allocation_id = aws_eip.MERN_NAT_EIP.id
  subnet_id     = values(aws_subnet.public_subnets)[0].id
  depends_on    = [aws_internet_gateway.MERN_IGW]
  tags = {
    Name = "NAT Gateway"
  }
}