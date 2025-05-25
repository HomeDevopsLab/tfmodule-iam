variable "name" {
  type = string
}

variable "custom_policy" {
  description = "Custom policy to attach to the user"
  type = string
  default = ""
}

variable "access_key" {
  description = "Create access key for the user"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags attached to resources"
  type = map(string)
  default = {}
}