variable "repository_name" {
  description = "Name of the ECR repository to be created"
  type = string
}

variable "tags_all" {
  type = map(string)
}