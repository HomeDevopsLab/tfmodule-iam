resource "aws_iam_user" "this" {
  name = var.name

  tags = var.tags
}

resource "aws_iam_policy" "this" {
  name        = "CustomPolicy"
  description = "Custom access policy"
  policy      = var.custom_policy

  tags = var.tags
}

resource "aws_iam_user_policy_attachment" "this" {
  user       = aws_iam_user.this.name
  policy_arn = aws_iam_policy.this.arn
}

resource "random_id" "rotate" {
  byte_length = 4
  keepers = {
    force_rotate = var.key_rotation ? timestamp() : "no"
  }
}


resource "aws_iam_access_key" "this" {
  for_each = var.access_key ? { "${random_id.rotate.hex}" = aws_iam_user.this.name } : {}
  user     = each.value

  lifecycle {
    create_before_destroy = true
  }

}

