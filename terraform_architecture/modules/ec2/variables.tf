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

variable "root_volume_size" {
  description = "value for the root volume size in GB"
  type = string
}

variable "root_volume_type" {
  description = "value for the root volume type"
  type        = string
  default     = "gp3"
}
