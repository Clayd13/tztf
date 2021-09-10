################################################################################
# VPC Module
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.7.0"


  name = "tz-tf-vpc"
  cidr = "10.100.0.0/16"

  azs            = ["${var.region_name}a"]
  public_subnets = ["10.100.101.0/24"]

  enable_ipv6 = false

  enable_nat_gateway = false
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    Name = "overridden-name-public"
  }

  tags = {
    Terraform   = "true"
    Environment = "tz"
  }

  vpc_tags = {
    Name = "vpc-name"
  }
}
