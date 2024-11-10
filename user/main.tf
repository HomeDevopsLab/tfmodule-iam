resource "aws_iam_user" "this" {
  name = var.name
}
resource "aws_iam_user_login_profile" "this" {
  user = aws_iam_user.this.name
  password_reset_required = true
}

data "aws_iam_policy_document" "change_password" {
  statement {
    actions = [ "iam:ChangePassword" ]
    resources = [ aws_iam_user.this.arn ]
    effect = "Allow"
  }
}

data "aws_iam_policy_document" "full_access" {
  statement {
    actions = [ "*" ]
    resources = [ "*" ]
    effect = "Allow"
  }
}

resource "aws_iam_policy" "this" {
  name        = "UserPolicy"
  description = "User access policy"
  policy      = var.full_access ? data.aws_iam_policy_document.full_access.json : data.aws_iam_policy_document.change_password.json
}

resource "aws_iam_user_policy_attachment" "this" {
  user       = aws_iam_user.this.name
  policy_arn = aws_iam_policy.this.arn
}
