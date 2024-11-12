variable "access" {
  type = map(object({
    permissions = map(object({
      account_id = string
      role_name  = string
    }))
  }))
}