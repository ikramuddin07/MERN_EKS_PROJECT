# Use data source to get the default VPC and its default subnet
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

# Create an EC2 instance in the first default subnet
resource "aws_instance" "default_ec2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = data.aws_subnet_ids.default.ids[0]
  associate_public_ip_address = true

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = var.root_volume_type
    iops = 30000
    encrypted = true
  }

  tags = {
    Name = var.instance_name
  }
}
