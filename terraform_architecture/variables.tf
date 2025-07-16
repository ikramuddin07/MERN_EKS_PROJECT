variable "MERN_VPC_CIDR" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "default_region" {
  description = "Default AWS Region"
  type        = string
}

# EC2 Module Variables
variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-0c02fb55956c7d316" # Example Amazon Linux 2 in us-east-1
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}
