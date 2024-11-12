variable "access" {
  type = list(object({
    permissions = map(object({
      account_id = string
      role_name  = string
    }))
  }))
}