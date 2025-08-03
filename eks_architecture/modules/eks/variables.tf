variable "is-eks-cluster-enabled" {
  type    = bool
  default = true
}

variable "cluster-name" {
  type = string
}

variable "cluster-version" {
  type    = string
  default = "1.29"
}

variable "endpoint-private-access" {
  type    = bool
  default = false
}

variable "endpoint-public-access" {
  type    = bool
  default = true
}

variable "env" {
  type = string
}

variable "ondemand_instance_types" {
  type = list(string)
}

variable "spot_instance_types" {
  type = list(string)
}

variable "desired_capacity_on_demand" {
  type = number
}

variable "min_capacity_on_demand" {
  type = number
}

variable "max_capacity_on_demand" {
  type = number
}

variable "desired_capacity_spot" {
  type = number
}

variable "min_capacity_spot" {
  type = number
}

variable "max_capacity_spot" {
  type = number
}

variable "addons" {
  description = "List of EKS addons with name and version"
  type = list(object({
    name    = string
    version = string
  }))
}