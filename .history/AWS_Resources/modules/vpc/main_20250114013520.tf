resource "aws_vpc" "myvpc" {
  cidr_block = var.vpc_cidr
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_subnet" "sub_1" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = var.aws_subnet_1
  availability_zone = var.availability_zone_s1
}

resource "aws_subnet" "sub_2" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = var.aws_subnet_2
  availability_zone = var.availability_zone_s2
}

resource "aws_route_table" "rt-1" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = var.aws_subnet_rt_1
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_eip" "nat_ip" {
  domain = "vpc"
}
resource "aws_nat_gateway" "nt_g" {
  subnet_id = aws_subnet.sub_1.id
  allocation_id = aws_eip.nat_ip.id
  
}

resource "aws_route_table" "rt-2" {
  vpc_id = aws_vpc.myvpc.id
  route{
    cidr_block = var.aws_subnet_rt_2
    nat_gateway_id = aws_nat_gateway.nt_g.id
  }
}

resource "aws_route_table_association" "rta-1" {
  subnet_id = aws_subnet.sub_1.id
  route_table_id = aws_route_table.rt-1.id
}

resource "aws_route_table_association" "rta-2" {
  subnet_id = aws_subnet.sub_2.id
  route_table_id = aws_route_table.rt-2.id
}

resource "aws_security_group" "nsg" {
  vpc_id      = aws_vpc.myvpc.id
  ingress  {
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
    description = ""
    from_port = "0"
    to_port = "0"
    protocol    = "-1"
    cidr_blocks = var.egress_sg
  }
}




