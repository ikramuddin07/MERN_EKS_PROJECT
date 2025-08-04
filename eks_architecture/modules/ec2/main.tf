# Create an EC2 instance in the first private subnet
resource "aws_instance" "ec2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  availability_zone           = var.availability_zone
  user_data                   = var.user_data
  vpc_security_group_ids      = var.security_group_ids
  iam_instance_profile        = var.iam_instance_profile


  root_block_device {
    volume_size = var.root_volume_size
    volume_type = var.root_volume_type
    encrypted   = true
  }

  tags = {
    Name = var.instance_name
  }
}

