module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = "10.0.0.0/16"
  aws_subnet_1         = "10.0.1.0/24"
  aws_subnet_2         = "10.0.2.0/24"
  availability_zone_s1 = "us-east-1a"
  availability_zone_s2 = "us-east-1b"
  ingress_sg           = ["0.0.0.0/0"]
  egress_sg            = ["0.0.0.0/0"]
}

module "ec2" {
  source = "./modules/ec2"
  ami_id           = "ami-053b0d53c279acc90"
  instance_type    = "t2.micro"
  instance_name  = "webserver"
}

module "elb" {
  source           = "./modules/elb"
  ami_id           = "ami-053b0d53c279acc90"  # Replace with a valid AMI ID
  instance_type    = "t2.micro"
  elb_name         = "web-elb"
  subnet_ids       = ["subnet-09bfa4bbb2d3382b3", "subnet-031e6143ca811a913"]
  #security_groups  = ["sg-0bd5b996453300c38"]
  security_group_ids = ["sg-0123456789abcdef0"]
}

module "s3" {
  source             = "./modules/s3"
  bucket_name        = "my-simple-bucket-987654321"
  versioning_enabled = true
}

module "iam" {
  source = "./modules/iam"

  iam_group_name     = "DevOps"
  ec2_full_access    = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  s3_full_access     = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  aws_iam_user       = ["Kevin", "Dev", "Ram", "Jay"]
  policy_name        = "Deny_EC2_S3_Access"
  policy_description = "Policy to explicitly deny access to EC2 and S3"
  policy_json        = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Deny"
        Action   = ["ec2:*", "s3:*"]
        Resource = "*"
      }
    ]
  })
}

module "asg-ec2-cw-elb" {
  source               = "./modules/asg-ec2-cw-elb"  
  vpc_cidr             = "10.0.0.0/16"              
  aws_subnet_1         = "10.0.1.0/24"              
  aws_subnet_2         = "10.0.2.0/24"              
  availability_zone_s1 = "us-east-1a"               
  availability_zone_s2 = "us-east-1b"               
  ingress_sg           = ["0.0.0.0/0"]              
  egress_sg            = ["0.0.0.0/0"]              
  ami_id               = "ami-053b0d53c279acc90"     
  instance_type        = "t2.micro"                  
  elb_name             = "web-alb"                   
}

module "three-tier" {
  source = "./modules/threeTierArchitecture"
  db_password = "var.db_password"
}