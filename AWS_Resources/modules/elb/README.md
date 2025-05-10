# ELB with EC2 and Nginx Configuration

## **Overview**
This Terraform configuration creates an **Application Load Balancer (ALB)** along with two **EC2 instances** running **Nginx** in the **default VPC**. The EC2 instances are registered with the Load Balancer, and Nginx is installed to serve as a simple web server.

## **Key Components**
1. **EC2 Instances**:
   - Two EC2 instances (`web1` and `web2`) are launched with a basic Nginx installation. The instances are deployed in specified subnets.
   
2. **Security Group**:
   - A security group (`web_sg`) is created and associated with both EC2 instances and the load balancer. The security group allows HTTP (port 80) traffic from all IPs (`0.0.0.0/0`).
   
3. **Load Balancer**:
   - An Application Load Balancer (ALB) is created and deployed in the specified subnets. The load balancer listens on port 80 and uses HTTP protocol to distribute traffic.
   
4. **Target Group**:
   - A target group (`web-target-group`) is created and associated with the EC2 instances. The load balancer routes traffic to this group.

5. **Listener**:
   - A listener is created on port 80 for the load balancer. It sends a fixed response with a status code of 200 and a message "OK" for basic health checks.

## **Outcome**
- Two EC2 instances are launched and configured to run Nginx.
- A Load Balancer is created to route traffic to the EC2 instances.
- A security group is applied to allow HTTP traffic on port 80.
- A target group is created for registering EC2 instances with the load balancer.
- The load balancer is configured with a listener on port 80.

## **Steps to Deploy**
1. Initialize Terraform: `terraform init`
2. Plan the infrastructure: `terraform plan`
3. Apply the configuration: `terraform apply`