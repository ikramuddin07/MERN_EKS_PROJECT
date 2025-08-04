variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID to launch the EC2 instance into"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}


variable "root_volume_size" {
  description = "value for the root volume size in GB"
  type        = number
}

variable "root_volume_type" {
  description = "value for the root volume type"
  type        = string
  default     = "gp3"
}

variable "user_data" {
  description = "User data script to bootstrap the instance"
  type        = string
  default     = ""
}

variable "availability_zone" {
  description = "Optional availability zone for the instance"
  type        = string
  default     = ""
}

variable "security_group_ids" {
  description = "List of security group IDs to attach to the EC2 instance"
  type        = list(string)
}

variable "iam_instance_profile" {
  description = "The name of the IAM instance profile"
  type        = string
  default     = null
}

variable "env" {
  description = "Environment of the EC2 instance"
  type = string
}