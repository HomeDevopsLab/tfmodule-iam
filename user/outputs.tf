output "iam_user_arn" {
  value = aws_iam_user.this.arn
}

output "secret" {
  value     = aws_iam_access_key.this[0].secret
  sensitive = true
}

output "smtp_secret" {
  value     = aws_iam_access_key.this[0].ses_smtp_password_v4
  sensitive = true
}