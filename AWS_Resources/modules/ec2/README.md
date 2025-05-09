# EC2 Instance Creation Overview

## **Overview**
This Terraform configuration is used to create an EC2 instance on AWS. The EC2 instance is provisioned in the default VPC with a security group allowing SSH access. It is dynamically configured with an SSH key pair for secure access.

## **Key Components**
1. **AWS EC2 Instance**:
   - The EC2 instance is created using a specific Amazon Machine Image (AMI) and instance type (`t2.micro`).
   - The instance will be launched in the default VPC, using the default subnet and security group.

2. **Security Group**:
   - A custom security group is created to allow inbound traffic on port 22 (SSH).
   - This allows remote access to the EC2 instance via SSH.

3. **SSH Key Pair**:
   - A dynamic SSH key pair is generated using Terraform's `tls` and `random` providers.
   - The private key is stored locally for SSH access to the EC2 instance.

## **Outcome**
- A secure EC2 instance is launched.
- SSH access is granted via a dynamically created key pair.
- Security group rules ensure that only SSH traffic is allowed.

## **Steps to Deploy**
1. Initialize Terraform: `terraform init`
2. Plan the infrastructure: `terraform plan`
3. Apply the configuration: `terraform apply`
