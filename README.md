# About

This project implements secure and scalable **Multi-tier Architecture** in AWS within a custom VPC. It includes EC2 instances for Web and Application tiers, with AutoScaling to dynamically adjust capacity based on traffic and workload. An Application LoadBalancer distributes traffic to the Web Tier for high availability, while a MySQL database in private subnets securely stores application data and monitor the EC2 performance using CloudWatch. This architecture ensures fault tolerance, optimal resource usage, and secure communication between tiers.

*The repository includes infrastructure code for provisioning AWS resources such as EC2, S3, IAM, VPC, Load Balancer, Auto Scaling, RDS, and CloudWatch for a scalable and highly available application environment.*

