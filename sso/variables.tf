variable "access" {
  type = map(list(object({
    account_id = string
    role_name = string
  })))
}