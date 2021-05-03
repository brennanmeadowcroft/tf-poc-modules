variable "ENV" {
}

variable "AWS_REGION" {
}

module "main-vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-${var.ENV}"
  cidr = "10.0.0.0/16"

  azs            = ["${var.AWS_REGION}a"]
  public_subnets = ["10.0.1.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = var.ENV
  }
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.main-vpc.vpc_id
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.main-vpc.public_subnets
}

