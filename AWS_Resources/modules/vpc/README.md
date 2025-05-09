# VPC Setup Overview

## **Overview**
This Terraform configuration creates a custom Virtual Private Cloud (VPC) in AWS. The configuration includes:
- Two subnets across different availability zones.
- An Internet Gateway for public internet access.
- A NAT Gateway for private subnet internet access.
- Custom route tables and associations for routing between public and private subnets.
- A security group with rules to allow SSH, HTTP, and HTTPS traffic.

## **Key Components**
1. **VPC**:
   - A custom VPC is created with the CIDR block `10.0.0.0/16`.
   
2. **Subnets**:
   - Two subnets are created: `subnet-1-prod` with CIDR `10.0.1.0/24` and `subnet-2-prod` with CIDR `10.0.2.0/24`.
   
3. **Internet Gateway**:
   - An Internet Gateway is created and attached to the VPC to allow internet access for the public subnet.

4. **NAT Gateway**:
   - A NAT Gateway is created for enabling private subnets to access the internet.

5. **Route Tables and Associations**:
   - Route tables are created for both public and private subnets with the necessary routes and associations.

6. **Security Group**:
   - A security group is created with rules allowing SSH, HTTP, and HTTPS traffic from all sources.

## **Outcome**
- A fully functioning VPC with public and private subnets, internet access, and security group settings to allow SSH and HTTP(S).
- Subnets, routing, and a security group tailored to support resources like EC2 instances.

## **Steps to Deploy**
1. Initialize Terraform: `terraform init`
2. Plan the infrastructure: `terraform plan`
3. Apply the configuration: `terraform apply`
