# IAM User, Group, and Policy Creation Overview

## **Overview**
This Terraform configuration manages IAM resources, including creating users, groups, and policies. The IAM group is created with the necessary permissions for EC2 and S3 access. A custom policy is created to deny access to both EC2 and S3, which can be applied as needed.

## **Key Components**
1. **IAM Group**:
   - A new IAM group is created, which can be used to manage access control for IAM users.

2. **IAM Users**:
   - IAM users are created dynamically using a list of names. These users are added to the IAM group with the necessary access permissions.

3. **IAM Group Policy Attachments**:
   - The group is attached to AWS-managed policies for full access to EC2 (`AmazonEC2FullAccess`) and S3 (`AmazonS3FullAccess`).
   
4. **Custom IAM Policy**:
   - A custom policy is created to explicitly deny access to both EC2 and S3 resources. This is useful for tightening security when necessary.

5. **IAM Group Membership**:
   - The users are added to the IAM group, and the permissions are inherited from the policies attached to the group.

## **Outcome**
- IAM users are created and added to a group with appropriate permissions for EC2 and S3 access.
- A custom deny policy is created and can be applied to restrict access to EC2 and S3 resources if needed.

## **Steps to Deploy**
1. Initialize Terraform: `terraform init`
2. Plan the infrastructure: `terraform plan`
3. Apply the configuration: `terraform apply`
