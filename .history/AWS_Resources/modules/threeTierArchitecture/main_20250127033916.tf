# 3-Tier AWS Architecture
# Creating VPC Configuration
resource "aws_vpc" "myvpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "MyVPC"
  }
}

# Creating Public Subnet 1
resource "aws_subnet" "subnet_1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.aws_subnet_1
  availability_zone       = var.availability_zone_s1
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnet 1"
  }
}

# Creating Private Subnet 2
resource "aws_subnet" "subnet_2" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.aws_subnet_2
  availability_zone       = var.availability_zone_s2
  map_public_ip_on_launch = false
  tags = {
    Name = "Private Subnet 2"
  }
}

# Internet Gateway for public subnet
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "MyInternetGateway"
  }
}

# Elastic IP for NAT Gateway (needed for private subnet internet access)
resource "aws_eip" "nat_ip" {
  domain = "vpc"
}

# NAT Gateway in Public Subnet 1
resource "aws_nat_gateway" "nat_gw" {
  subnet_id     = aws_subnet.subnet_1.id
  allocation_id = aws_eip.nat_ip.id
  tags = {
    Name = "MyNATGateway"
  }
}

# Public Route Table (for Subnet 1)
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

# Associating Public Route Table with Subnet 1
resource "aws_route_table_association" "public_rta" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

# Private Route Table (for Subnet 2)
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "Private Route Table"
  }
}

# Associating Private Route Table with Subnet 2
resource "aws_route_table_association" "private_rta" {
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.private_rt.id
}

# Security Group Configuration
resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.myvpc.id

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
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.egress_sg
  }

  tags = {
    Name = "WebServerSG"
  }
}

# Creating a Key Pair dynamically every time
resource "random_id" "keypair_id" {
  byte_length = 8
}

resource "tls_private_key" "generated_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "dynamic_keypair" {
  key_name   = "ec2-keypair-${random_id.keypair_id.hex}"
  public_key = tls_private_key.generated_key.public_key_openssh 

  tags = {
    Name = "KeyPair-${random_id.keypair_id.hex}"
  }
}

resource "null_resource" "save_private_key" {
  provisioner "local-exec" {
    command = "echo '${tls_private_key.generated_key.private_key_pem}' > ${var.key_pair_base_download_path}/Downloads/ec2-keypair-${random_id.keypair_id.hex}.pem"
  }

  depends_on = [aws_key_pair.dynamic_keypair]
}



# EC2 Instance Configuration in the Private Subnet (with NAT Gateway for Internet Access)
resource "aws_instance" "webserver" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.subnet_1.id
  vpc_security_group_ids = [aws_security_group.sg.id]
  key_name      = aws_key_pair.dynamic_keypair.key_name  
  associate_public_ip_address = true

  tags = {
    Name = var.ec2_server
  }
}

# resource "aws_lb_listener" "http" {
#   load_balancer_arn = aws_lb.test-lb.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.tg.arn
#   }
# }

# Creating an Application Load Balancer
resource "aws_lb" "my_alb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]

  enable_deletion_protection = false

  tags = {
    Name = "MyALB"
  }
}

# Creating Target Group
resource "aws_lb_target_group" "my_target_group" {
  name     = "my-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.myvpc.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = {
    Name = "MyTargetGroup"
  }
}

# Creating Load Balancer Listener
resource "aws_lb_listener" "my_alb_listener" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "fixed-response"
    fixed_response {
      status_code = 200
      content_type = "text/plain"
      message_body = "OK"
    }
  }
}

resource "aws_security_group" "alb_sg" {
  name        = "alb_sg"
  description = "Allow HTTP traffic to ALB"
  vpc_id      = aws_vpc.myvpc.id  

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  tags = {
    Name = "ALB Security Group"
  }
}

resource "aws_db_instance" "my_sql_db" {
  engine = "mysql"
  instance_class = "db.t4g.micro"
  #engine_version = "Mysql 8.0.39"
  vpc_security_group_ids = [aws_security_group.sg.id]
  db_subnet_group_name = aws_db_subnet_group.subnet_group.name
  username = "Admin"
  password = var.db_password
  allocated_storage = 20 
  #storage_type = gp2
  multi_az = false
  publicly_accessible = false  
 # skip_final_snapshot = true
  #final_snapshot_identifier = "final-snapshot-before-destroy-${random_id.keypair_id.hex}"
}

resource "aws_db_subnet_group" "subnet_group" {
  name = "db-subnet-group"
  subnet_ids = [aws_subnet.subnet_1.id,aws_subnet.subnet_2.id]
  tags = {
    Name = "DB Subnet Group"
  }
}

resource "aws_security_group" "db_sec_group" {
  name        = "db_sg"
  description = "Allow inbound MySQL traffic to DB tier"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.aws_subnet]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_launch_template" "scaling_template" {
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.dynamic_keypair.key_name
  # subnet_id     = aws_subnet.subnet_1.id
  vpc_security_group_ids = [aws_security_group.sg.id]
  #vpc_security_group_ids = [aws_security_group.launch_template_sg.id]
  #security_group_ids = [aws_security_group.sg.id]

}

resource "aws_autoscaling_group" "webserver_asg" {
  depends_on = [
    aws_launch_template.scaling_template,  # Ensure launch template is created first
    aws_subnet.subnet_1,                   # Ensure subnet_1 is created first
    aws_subnet.subnet_2                    # Ensure subnet_2 is created first
  ]
  desired_capacity = 2
  min_size = 2
  max_size = 5
  #vpc_id = aws_vpc.myvpc.id
  vpc_zone_identifier  = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]
  launch_template {
    id      = aws_launch_template.scaling_template.id
    
  }
  health_check_type          = "EC2"
  health_check_grace_period = 300
  target_group_arns = [aws_lb_target_group.my_target_group.arn] 
 
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_high" {
  alarm_name                = "High-CPU-Utilization"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 1
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 300
  threshold                 = 70
  dimensions = {
    InstanceId = aws_instance.webserver.id
  }
  statistic                 = "Average"
  tags = {
    name = "High-Utilization-alarm"
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_low" {
  alarm_name                = "Low-CPU-Utilization"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = 1
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 300
  threshold                 = 30
  dimensions = {
    InstanceId = aws_instance.webserver.id
  }
  statistic                 = "Average"
  tags = {
    name = "Low-Utilization-alarm"
  }
}


