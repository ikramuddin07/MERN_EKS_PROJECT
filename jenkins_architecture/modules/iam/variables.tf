variable "role_name" {
  description = "Name of the IAM role"
  type        = string
}

variable "policy_arn" {
  description = "ARN of the policy to attach"
  type        = string
}
