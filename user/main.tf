resource "aws_iam_user" "this" {
  name = var.name
}
resource "aws_iam_user_login_profile" "this" {
  user = aws_iam_user.this.name
  password_reset_required = true
}