output "password" {
  value     = aws_iam_user_login_profile.this.password
  sensitive = true
}
output "secret" {
  value     = aws_iam_access_key.this[0].secret
  sensitive = true
}