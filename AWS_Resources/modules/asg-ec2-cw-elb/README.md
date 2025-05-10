# Terraform Infrastructure Setup: Auto Scaling Group, EC2, CloudWatch, and Load Balancer

## **Overview**

This Terraform configuration manages the creation of an **Auto Scaling Group (ASG)**, **EC2 Instances**, **Elastic Load Balancer (ELB)**, and **CloudWatch Alarms** within a custom VPC. The configuration allows you to automatically scale your EC2 instances based on traffic thresholds and monitor them with CloudWatch alarms.

## **Key Components**

1. **VPC (Virtual Private Cloud)**:
   - A custom VPC is created to host your EC2 instances, ASG, and load balancer.
   - The VPC includes multiple subnets to support high availability.
   - The VPC has associated route tables, an Internet Gateway (IGW), and a NAT Gateway.

2. **EC2 Instances**:
   - EC2 instances are launched in the VPC with a specified **AMI ID** and **instance type**.
   - [Learn more about EC2 Instances](https://docs.aws.amazon.com/ec2/index.html)

3. **Auto Scaling Group (ASG)**:
   - An ASG is configured to automatically scale the number of EC2 instances based on CPU utilization or traffic load.
   - [Learn more about Auto Scaling Groups](https://docs.aws.amazon.com/autoscaling/ec2/userguide/what-is-asg.html)

4. **Elastic Load Balancer (ELB)**:
   - An **Application Load Balancer (ALB)** is created to distribute incoming traffic across EC2 instances in multiple availability zones.
   - [Learn more about ELB](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html)

5. **CloudWatch Alarms**:
   - CloudWatch Alarms are configured to monitor the performance of EC2 instances and trigger scaling actions based on metrics like CPU utilization or memory usage.
   - [Learn more about CloudWatch](https://aws.amazon.com/cloudwatch/index.html)

## **Architecture Flow**

1. **VPC**: A custom VPC with two subnets, one in each availability zone. The VPC is connected to the internet through an IGW and a NAT Gateway.
2. **EC2**: EC2 instances are launched in the VPC, running a simple web server (Nginx) that serves a "Welcome" message on HTTP.
3. **ASG**: The Auto Scaling Group ensures that the desired number of EC2 instances is always running based on the traffic load, scaling up or down based on CloudWatch metrics.
4. **ELB**: The Load Balancer distributes incoming traffic to the EC2 instances, ensuring availability and fault tolerance.
5. **CloudWatch**: CloudWatch monitors the metrics of EC2 instances and triggers scaling actions when necessary.

## **Services Used**

- **[VPC (Virtual Private Cloud)](https://aws.amazon.com/vpc/)**
- **[EC2 (Elastic Compute Cloud)](https://aws.amazon.com/ec2/)**
- **[Auto Scaling Groups (ASG)](https://aws.amazon.com/autoscaling/)**
- **[Elastic Load Balancer (ELB)](https://aws.amazon.com/elasticloadbalancing/)**
- **[CloudWatch](https://aws.amazon.com/cloudwatch/)**

## **Outcome**

- A fully functioning **VPC** with two subnets in different availability zones, internet access via an **Internet Gateway (IGW)**, and proper routing.
- EC2 instances are deployed in the subnets with Nginx installed, serving a basic "Welcome" page.
- An **Auto Scaling Group (ASG)** is created, automatically scaling the number of EC2 instances based on CPU utilization or traffic load.
- An **Elastic Load Balancer (ELB)** (Application Load Balancer) is set up to distribute incoming traffic across the EC2 instances.
- **CloudWatch Alarms** are configured to monitor EC2 instance metrics, triggering scaling actions when necessary to handle fluctuating traffic.
- The **security groups** for EC2 instances allow HTTP (port 80), HTTPS (port 443), and SSH (port 22) access from specified CIDR blocks.
- The system is designed for high availability and fault tolerance, with EC2 instances spread across multiple availability zones and an Auto Scaling Group ensuring the appropriate number of instances are running based on the load.

This setup provides a scalable and monitored web application architecture, automatically adjusting the compute capacity based on traffic conditions and ensuring your web service remains available and performant.

## **Steps to Deploy**
1. Initialize Terraform: `terraform init`
2. Plan the infrastructure: `terraform plan`
3. Apply the configuration: `terraform apply`