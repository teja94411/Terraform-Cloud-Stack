variable "iam_group_name" {
  description = "IAM group name"
  type        = string
}

variable "ec2_full_access" {
  description = "IAM policy ARN for EC2 full access"
  type        = string
}

variable "s3_full_access" {
  description = "IAM policy ARN for S3 full access"
  type        = string
}

variable "aws_iam_user" {
  description = "List of IAM users to create"
  type        = list(string)
}

variable "policy_name" {
  description = "IAM policy name"
  type        = string
}

variable "policy_description" {
  description = "IAM policy description"
  type        = string
}

variable "policy_json" {
  description = "JSON string for custom IAM policy"
  type        = string
}
