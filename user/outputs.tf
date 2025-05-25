output "secret" {
  value     = aws_iam_access_key.this[0].secret
  sensitive = true
}