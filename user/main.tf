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

resource "null_resource" "rotate_trigger" {
  triggers = {
    rotate = var.key_rotation ? timestamp() : "no"
  }
}


resource "aws_iam_access_key" "this" {
  count = var.access_key ? 1 : 0
  user  = aws_iam_user.this.name

  depends_on = [ null_resource.rotate_trigger ]

  lifecycle {
    create_before_destroy = true
  }
}

