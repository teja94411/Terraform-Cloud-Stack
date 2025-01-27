module "vpc" {
  source = "./modules/vpc"
}

module "ec2" {
  source = "./modules/ec2"
}

module "elb" {
  source = "./modules/elb"
}

module "s3" {
  source = "./modules/s3" 
}

module "iam" {
  source = "./modules/iam"
}

module "three-tier" {
  source = "./modules/threeTierArchitecture"
  db_password = "var.db_password"
}