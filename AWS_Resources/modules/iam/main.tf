resource "aws_iam_group" "group_name" {
  name = var.iam_group_name
}

resource "aws_iam_group_policy_attachment" "ec2_full_access" {
  group      = aws_iam_group.group_name.name
  policy_arn = var.ec2_full_access
}

resource "aws_iam_group_policy_attachment" "s3_full_access" {
  group      = aws_iam_group.group_name.name
  policy_arn = var.s3_full_access
}

resource "aws_iam_user" "new_iam_user" {
  for_each = toset(var.aws_iam_user)  
  name     = each.value  # Referencing each user name correctly
}

resource "aws_iam_group_membership" "add_user_to_group" {
  name  = "group-membership-${aws_iam_group.group_name.name}"  # Unique name for the membership
  group = aws_iam_group.group_name.name
  users = tolist([for user in aws_iam_user.new_iam_user : user.name])  # Extracting list of usernames
}

resource "aws_iam_policy" "deny_ec2_s3_policy" {
  name        = var.policy_name
  description = var.policy_description
  policy      = var.policy_json
}

