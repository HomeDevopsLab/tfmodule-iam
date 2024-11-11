variable "access" {
  type = list(object({
    username    = string
    role_name   = string
    account_id = string
  }))
}