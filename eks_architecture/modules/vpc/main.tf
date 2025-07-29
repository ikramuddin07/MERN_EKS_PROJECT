# This is the main VPC Infrastructure, It consists of:
# 1. VPC
# 2. Subnets (3 Public, 3 Private) Spread across multiple AZ's
# 3. Route tables and route tables association
# 4. Internet Gateway and NAT Gateway

######################################################
# Defining a VPC
######################################################

resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr

    tags = {
      Name = var.vpc_name
    }
  
}

######################################################
# Defining the Public and Private Subnets
######################################################
# Create a data block to lookup the Availablity zones in the Region
data "aws_availability_zones" "available" {}

# Create the public subnets
resource "aws_subnet" "public_subnets" {
  for_each = var.public_subnets
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, each.value + 100)
  availability_zone = data.aws_availability_zones.available.names[each.value]
  map_public_ip_on_launch = true

  tags = {
    Name = each.key
  }
}

# Create the private subnets
resource "aws_subnet" "private_subnets" {
  for_each = var.private_subnets
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, each.value)
  availability_zone = data.aws_availability_zones.available.names[each.value]
  
  tags = {
    Name = each.key
  }
}

######################################################
# Defining the Internet Gateway
######################################################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.igw_name
  }
}

######################################################
# Defining to use Elastic IP for NAT Gateway
######################################################
resource "aws_eip" "nat_eip" {
  domain = "vpc"
  depends_on = [ aws_internet_gateway.igw ]

  tags = {
    Name = var.nat_eip_name
  }
}

######################################################
# Defining the NAT Gateway
######################################################
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id = values(aws_subnet.public_subnets)[0].id
  depends_on = [ aws_internet_gateway.igw ]

  tags = {
    Name = var.nat_gateway_name
  }
}

#####################################################################################
# Defining the Route Tables for Public (IGW) and Private (NAT) Subnets
#####################################################################################

# Create Route Table for public subnets
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public-RT"
  }
}

# Create the route table for private subnets
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "Private-RT"
  }
}
#####################################################################################
# Defining the Route Table associations for Public (IGW) and Private (NAT) Subnets
#####################################################################################

# Create route table association for public subnets
resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public_subnets
  subnet_id = each.value.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private_subnets
  subnet_id = each.value.id
  route_table_id = aws_route_table.private_route_table.id
}