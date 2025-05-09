output "iam_group_name" {
  description = "The name of the IAM group"
  value       = aws_iam_group.group_name.name
}

output "aws_iam_user" {
  description = "List of created IAM users"
  value       = [for user in aws_iam_user.new_iam_user : user.name]
}

output "deny_ec2_s3_policy" {
  description = "The IAM policy that denies EC2 and S3 access"
  value       = aws_iam_policy.deny_ec2_s3_policy.arn
}
