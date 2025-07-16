variable "MERN_VPC_CIDR" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "default_region" {
  description = "Default AWS Region"
  type        = string
}

variable "private_subnets" {
  description = "Map of private subnet names to AZ index"
  type        = map(number)
  default = {
    "private_subnet_1" = 0
    "private_subnet_2" = 1
    "private_subnet_3" = 2
  }
}

variable "public_subnets" {
  description = "Map of public subnet names to AZ index"
  type        = map(number)
  default = {
    "public_subnet_1" = 0
    "public_subnet_2" = 1
    "public_subnet_3" = 2
  }
}