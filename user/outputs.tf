output "iam_user_arn" {
  value = aws_iam_user.this.arn
}

output "secret" {
  description = "The secret access key for the IAM user."
  value     = var.access_key ? aws_iam_access_key.this[0].secret : null
  sensitive = true
}