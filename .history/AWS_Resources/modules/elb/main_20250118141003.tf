resource "aws_vpc" "myvpc" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "sub_1" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = var.aws_subnet_1
  availability_zone = var.availability_zone_s1
}

resource "aws_subnet" "sub_2" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = var.aws_subnet_2
  availability_zone = var.availability_zone_s2
}

resource "aws_security_group" "nsg" {
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
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.egress_sg
  }
}

resource "aws_lb" "test-lb" {
  name               = "test-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.nsg.id]
  subnets            = [aws_subnet.sub_1.id, aws_subnet.sub_2.id]
  ip_address_type    = "ipv4"
}

resource "aws_lb_target_group" "tg" {
  name     = "test-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.myvpc.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.test-lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
}