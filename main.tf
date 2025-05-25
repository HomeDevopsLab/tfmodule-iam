resource "aws_iam_user" "this" {
  name = var.name
}
resource "aws_iam_user_login_profile" "this" {
  user                    = aws_iam_user.this.name
  password_reset_required = var.password_reset_required
}

data "aws_iam_policy_document" "this" {
  for_each = { for idx, policy in var.custom_policy : idx => policy }
  statement {
    actions   = each.value.actions
    resources = each.value.resources
    effect    = each.value.effect
    sid       = "CustomPolicy${each.key}"
  }
}

resource "aws_iam_policy" "this" {
  for_each    = { for idx, policy in var.custom_policy : idx => policy }
  name        = "UserPolicy"
  description = "User access policy"
  policy      = data.aws_iam_policy_document.this[each.key].json
}

resource "aws_iam_user_policy_attachment" "this" {
  for_each   = { for idx, policy in var.custom_policy : idx => policy }
  user       = aws_iam_user.this.name
  policy_arn = aws_iam_policy.this[each.key].arn
}

resource "aws_iam_access_key" "this" {
  count = var.access_key ? 1 : 0
  user  = aws_iam_user.this.name
}

