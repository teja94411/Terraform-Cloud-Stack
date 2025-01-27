variable "iam_group_name" {
    description = "creating iam group"
    default = "DevOps" 
}

variable "ec2_full_access" {
    description = "attaching the ec2 full access"
    default = "arn:aws:iam::aws:policy/AmazonEC2FullAccess" 
}

variable "s3_full_access" {
    description = "attaching the s3 full access"
    default = "arn:aws:iam::aws:policy/AmazonS3FullAccess" 
}

variable "aws_iam_user" {
  description = "List of IAM users to create"
  default     = ["Kevin", "Dev", "Ram", "Jay"]
}

variable "policy_name" {
  description = "Name of the IAM policy"
  default     = "Deny_EC2_S3_Access"
}

variable "policy_description" {
  description = "Description of the IAM policy"
  default     = "Policy to explicitly deny access to EC2 and S3"
}

variable "policy_json" {
  description = "The JSON policy document"
  default = <<Policy
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Action": [
        "ec2:*",
        "s3:*"
      ],
      "Resource": "*"
    }
  ]
}
Policy
}

