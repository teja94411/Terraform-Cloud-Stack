# S3 Bucket Creation Overview

## **Overview**
This Terraform configuration manages the creation and configuration of an S3 bucket in AWS. It sets up the bucket with versioning, server-side encryption, and public access restrictions. The configuration also enforces ownership controls to ensure the bucket owner has full control over the objects stored.

## **Key Components**
1. **S3 Bucket**:
   - A new S3 bucket is created with the specified name. The bucket can be used to store objects and data in AWS.

2. **Bucket Versioning**:
   - Versioning is enabled or suspended on the S3 bucket based on the configuration, allowing for tracking of changes to objects stored in the bucket over time.

3. **Public Access Block**:
   - Public access to the S3 bucket is blocked by default, ensuring that the bucket and its contents are not publicly accessible unless explicitly configured.

4. **Server-Side Encryption**:
   - The S3 bucket is configured to automatically encrypt all objects stored in it using the `AES256` encryption algorithm. This ensures data confidentiality.

5. **Ownership Controls**:
   - Ownership controls are set to ensure the bucket owner has full control over all objects, even if other users upload them.

## **Outcome**
- An S3 bucket is created with versioning enabled or suspended based on the configuration.
- The bucket is protected with server-side encryption to secure stored data.
- Public access is blocked by default, preventing unauthorized access.
- Ownership controls ensure the bucket owner has full control over objects.

## **Steps to Deploy**
1. Initialize Terraform: `terraform init`
2. Plan the infrastructure: `terraform plan`
3. Apply the configuration: `terraform apply`
