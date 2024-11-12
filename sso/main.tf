locals {
  aws_roles = {
    PowerUserAccess = {
      name = "PowerUserAccess"
      policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
    },
    AdministratorAccess = {
      name = "AdministratorAccess"
      policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
    }
  }

  access_data = flatten([
    for username, userdata  in var.access : [
      for account_name, permission in userdata.permissions : {
        username = username
        account_name = account_name
        account_id = permission.account_id
        role_name = permission.role_name
      }
    ]
  ])
}

data "aws_ssoadmin_instances" "this" {}

resource "aws_ssoadmin_permission_set" "this" {
  for_each = tomap(local.aws_roles)
  name = each.value.name
  instance_arn = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  session_duration = "PT1H"
}

resource "aws_ssoadmin_managed_policy_attachment" "this" {
  for_each = tomap(local.aws_roles)
  instance_arn = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  managed_policy_arn = each.value.policy_arn
  permission_set_arn = aws_ssoadmin_permission_set.this[each.key].arn
}

data "aws_identitystore_user" "this" {
  for_each = tomap(var.access)
  identity_store_id =  tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
  alternate_identifier {
    unique_attribute {
      attribute_path = "UserName"
      attribute_value = each.key
    }
  }
}

resource "aws_ssoadmin_account_assignment" "this" {
  for_each = tomap({ for accessconfig in local.access_data : "${accessconfig.account_name}" => accessconfig })
  
  instance_arn = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.this[each.value.role_name].arn
  
  principal_id = data.aws_identitystore_user.this[each.value.username].id
  principal_type = "USER"
  
  target_id = each.value.account_id
  target_type = "AWS_ACCOUNT"
}