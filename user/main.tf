resource "aws_iam_user" "this" {
  name = var.name
}
resource "aws_iam_user_login_profile" "this" {
  user = aws_iam_user.this.name
  password_reset_required = true
}

data "aws_iam_policy_document" "this" {
  statement {
    actions = [ "iam:ChangePassword" ]
    resources = [ aws_iam_user.this.arn ]
    effect = "Allow"
  }
}

resource "aws_iam_policy" "this" {
  name        = "ChangePassword"
  description = "Allow users to change their own password"
  policy      = data.aws_iam_policy_document.this.json
}

resource "aws_iam_user_policy_attachment" "this" {
  user       = aws_iam_user.this.name
  policy_arn = aws_iam_policy.this.arn
}
