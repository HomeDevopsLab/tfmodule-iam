variable "name" {
  type = string
}

variable "password_reset_required" {
  description = "value to give console access to the user"
  type        = bool
  default     = false
}

variable "custom_policy" {
  description = "Custom policy to attach to the user"
  type = list(map({
    actions   = list(string)
    resources = list(string)
    effect    = string
  }))
  default = []
}

variable "access_key" {
  description = "Create access key for the user"
  type        = bool
  default     = false
}