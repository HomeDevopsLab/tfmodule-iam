variable "role_name" {
  description = "Name of the IAM role"
  type = string
}

variable "assume_policy" {
  description = "Policy in JSON format"
  type = string
}

variable "role_policy" {
  description = "IAM Role policy in JSON format"
  type = string
}

variable "tags" {
  description = "Tags associated to IAM role"
  type = map(string)
  default = {}
}