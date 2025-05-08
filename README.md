# Terraform

Terraform is an open-source tool by **HashiCorp** that lets you define, create, and manage **Infrastructure as Code**. Using a simple configuration language (HCL or JSON), you can manage resources across multiple platforms like **AWS, Azure, GCP, Kubernetes, and GitHub**. It handles everything from low-level components like servers and networks to high-level resources like DNS and SaaS features, ensuring your infrastructure is consistent, versioned, and automated.

# Installing Terraform

**Prerequisites**

  • A terminal or command prompt.

  • Internet access to download Terraform binaries.

  • Administrative privileges to install and configure Terraform.
  

# Installation Steps for Windows

1.Download the Terraform binary:

   **https://developer.hashicorp.com/terraform/install#windows**
   
2.Extract the .zip file to a desired folder (e.g., C:\Terraform).

3.Add the folder to your system’s PATH.

 (i)  Go to Control Panel → System and Security → System.
    
(ii)  Click Advanced system settings → Environment Variables.
    
(iii) Under System Variables, find Path → Edit → Add the folder containing terraform.exe.

   
4. Open a new Command Prompt and verify installation:

```bash
terraform version
```

# For Other Operating Systems
Follow the official instructions for your platform:

https://developer.hashicorp.com/terraform/install#darwin --> For MacOS

https://developer.hashicorp.com/terraform/install#linux  --> For Linux


## 1. **Initialize Terraform Working Directory**
Initializes the working directory containing Terraform configuration files. Downloads necessary provider plugins.

```bash
terraform init
```

## 2. Validate Configuration
Validates the syntax and structure of your Terraform configuration files (.tf).

```bash
terraform validate
```

## 3. Generate an Execution Plan
Generates and shows an execution plan that describes the actions Terraform will take to create or modify resources.

```bash
terraform plan
```

## 4. Apply the Changes
Applies the configuration to create or update the resources in the cloud provider, such as AWS, GCP, Azure, etc.

```bash
terraform apply
```

## 5. Destroy Infrastructure
Destroys all resources created by Terraform and cleans up the environment.

```bash
terraform destroy
```

## 6. Format Configuration Files
Automatically formats .tf files according to Terraform style conventions.

```bash
terraform fmt
```

## 7. Show Current State
Displays the current state of the infrastructure managed by Terraform, comparing it to the state in the .tfstate file.

```bash
terraform show
```

## 8. List Available Providers
Lists all available Terraform providers installed in the current environment.

```bash
terraform providers
```

## 9. Get Provider Plugins
Downloads the required provider plugins specified in the configuration files.

```bash
terraform get
```

## 10. Output Values
Displays the output values defined in the Terraform configuration.

```bash
terraform output
```

## 11. Import Existing Infrastructure
Imports existing infrastructure resources (like an EC2 instance) into Terraform management by specifying their ID.

```bash
terraform import <resource_type>.<resource_name> <resource_id>
```

## 12. State Management
Manage the state of the resources, such as moving or renaming resources.

List state resources:

```bash
terraform state list
```

Show state of a specific resource:

```bash
terraform state show <resource_name>
```

Remove a resource from the state file:

```bash
terraform state rm <resource_name>
```

## 13. Provisioners
Executes commands on a resource during creation or destruction. Used for tasks like bootstrapping.

Run a script after creating a resource:

```bash
terraform apply -var 'some_variable=some_value'
```

## 14. Create a Plan File (Optional)
Creates an execution plan and writes it to a file. This plan can be applied later using the plan file.

```bash
terraform plan -out=<filename>
```

## 15. Apply a Specific Plan
Applies a previously generated plan from a file.

```bash
terraform apply <filename>
```

## 16. Upgrade Provider or Terraform Version
Upgrades the Terraform CLI or specific providers.

```bash
terraform upgrade
```

## 17. List Available Modules
Lists the modules available for use in the current project.

```bash
terraform modules
```

## 18. Check for Updates
Checks if any Terraform providers or modules have updates available.

```bash
terraform providers lock -upgrade
```

## 19. Force Reapply Resources
Forces Terraform to reapply a specific resource, even if there were no changes detected.

```bash
terraform apply -replace="resource_name"
```

## 20. Get the Providers' Documentation
Fetches documentation for the providers or resources.

```bash
terraform providers -help
```

**The key features of Terraform are:-**

• **Infrastructure as Code:-** Infrastructure is described using a high-level configuration syntax. This allows a blueprint of your datacenter to be versioned and treated as you would any other code. 
 Additionally, infrastructure can be shared and re-used.

• **Execution Plans:-** Terraform has a "planning" step where it generates an execution plan. The execution plan shows what Terraform will do when you call apply. This lets you avoid any surprises when Terraform 
 manipulates infrastructure.

• **Resource Graph:-** Terraform builds a graph of all your resources, and parallelizes the creation and modification of any non-dependent resources. Because of this, Terraform builds infrastructure as 
 efficiently as possible, and operators get insight into dependencies in their infrastructure.

• **Change Automation:-** Complex changesets can be applied to your infrastructure with minimal human interaction. With the previously mentioned execution plan and resource graph, you know exactly what Terraform 
 will change and in what order, avoiding many possible human errors.

• **State Management:-** Maintains a state file (terraform.tfstate) to track the current infrastructure state and plan incremental changes.

• **Execution Plans:-** Before applying changes, Terraform generates a plan showing what will be added, changed, or destroyed.


# Repo Overview

This project implements secure and scalable **Multi-tier Architecture** in AWS within a custom VPC. It includes EC2 instances for Web and Application tiers, with AutoScaling to dynamically adjust capacity based on traffic and workload. An Application LoadBalancer distributes traffic to the Web Tier for high availability, while a MySQL database in private subnets securely stores application data and monitor the EC2 performance using CloudWatch. This architecture ensures fault tolerance, optimal resource usage, and secure communication between tiers.

*The repository includes infrastructure code for provisioning AWS resources such as EC2, S3, IAM, VPC, Load Balancer, Auto Scaling, RDS, and CloudWatch for a scalable and highly available application environment.*

