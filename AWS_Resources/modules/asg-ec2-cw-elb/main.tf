# VPC Setup
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "my-vpc-test"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "igw-my-vpc-test"
  }
}

resource "aws_subnet" "subnet_1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.aws_subnet_1
  availability_zone = var.availability_zone_s1
  tags = {
    Name = "subnet-1-test"
  }
}

resource "aws_subnet" "subnet_2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.aws_subnet_2
  availability_zone = var.availability_zone_s2
  tags = {
    Name = "subnet-2-test"
  }
}

resource "aws_route_table" "rt_1" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "rt-1-test"
  }
}

resource "aws_route_table" "rt_2" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nt_g.id
  }
  tags = {
    Name = "rt-2-test"
  }
}

resource "aws_eip" "nat_ip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nt_g" {
  subnet_id     = aws_subnet.subnet_1.id
  allocation_id = aws_eip.nat_ip.id
  tags = {
    Name = "nat-gateway-test"
  }
}

resource "aws_route_table_association" "rta_1" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.rt_1.id
}

resource "aws_route_table_association" "rta_2" {
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.rt_2.id
}

# Security Group for EC2 and ASG
resource "aws_security_group" "nsg" {
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ingress_sg
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.ingress_sg
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.ingress_sg
  }

  egress {
    description = "Allow All Outbound Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.egress_sg
  }

  tags = {
    Name = "my-vpc-security-group-test"
  }
}

# Launch Template for EC2 instances
resource "aws_launch_template" "web_server_template" {
  name_prefix   = "web-server-template"
  image_id      = var.ami_id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.nsg.id]  # Correct reference to security group
  user_data = base64encode(<<-EOF
  #!/bin/bash
  sudo apt-get update -y
  sudo apt-get install -y nginx
  sudo systemctl start nginx
  sudo systemctl enable nginx
EOF
)
}


# Auto Scaling Group (ASG) Setup
resource "aws_autoscaling_group" "asg" {
  desired_capacity     = 2
  max_size             = 4
  min_size             = 1
  vpc_zone_identifier  = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]

  launch_template {
    id = aws_launch_template.web_server_template.id
  }

  health_check_type          = "EC2"
  health_check_grace_period = 300
  force_delete              = true
  wait_for_capacity_timeout  = "0"
}

# Elastic Load Balancer (ELB) Setup
resource "aws_lb" "web_lb" {
  name               = var.elb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.nsg.id]
  subnets            = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]

  enable_deletion_protection = false
  enable_cross_zone_load_balancing = true
}

# CloudWatch Setup
resource "aws_cloudwatch_metric_alarm" "asg_high" {
  alarm_name          = "high-cpu-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_actions       = []
}

resource "aws_cloudwatch_metric_alarm" "elb_high" {
  alarm_name          = "high-elb-traffic"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "RequestCount"
  namespace           = "AWS/ApplicationELB"
  period              = 300
  statistic           = "Sum"
  threshold           = 1000
  alarm_actions       = []
}
