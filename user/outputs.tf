output "iam_user_arn" {
  value = aws_iam_user.this.arn
}

output "secret" {
  value     = aws_iam_access_key.this[0].secret
  sensitive = true
}