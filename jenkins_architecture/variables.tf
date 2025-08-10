variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "cidr_ipv4" {
  description = "IP which the instance is allowed to connect from"
  type        = string
}

# IAM Variables
variable "role_name" {
  description = "IAM EC2 Role Name"
  type        = string
}

variable "policy_arn" {
  description = "AWS Policy ARN"
  type        = string
}

variable "ec2_profile_name" {
  description = "Name of the EC2 Profile name"
  type        = string
}

# Jenkins Variables
variable "availability_zone" {
  description = "AZ which the EC2 will be deployed"
  type        = string
}

variable "instance_type" {
  description = "Type of EC2 Instance"
  type        = string
}

variable "root_volume_size" {
  description = "Volume in gig for the EC2 instance"
  type        = number
}

variable "root_volume_type" {
  description = "Voume type of EC2 instance"
  type        = string

}

variable "instance_name" {
  description = "EC2 Instance name"
  type        = string
}

variable "env" {
  description = "Environment of the EC2 instance"
  type        = string
}

