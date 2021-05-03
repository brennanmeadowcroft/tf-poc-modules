locals {
  teams = {
    "internal-app" = { app_name = "internal-app" }
    "external-app" = { app_name = "external-app" }
  }
}
module "main-vpc" {
  source     = "./modules/vpc"
  ENV        = var.ENV
  AWS_REGION = var.AWS_REGION
}

resource "aws_ssm_parameter" "vpc-id-param" {
  name  = "infra-networking-${var.ENV}-vpc-id"
  type  = "String"
  value = module.main-vpc.vpc_id
}

module "lambda-exec-role" {
  source                = "./modules/iam/"
  LAMBDA_EXEC_ROLE_NAME = "lambda-exec-role-12345"
}

module "microservice" {
  for_each = local.teams

  source   = "./modules/team-setup"
  ENV      = var.ENV
  APP_NAME = each.value.app_name
}

# Internal Team Resources
# resource "aws_s3_bucket" "internal_team_serverless_bucket" {
#   bucket = "internal-team-serverless-bucket-bm12345"
#   acl    = "private"

#   tags = {
#     Name        = "internal-team-serverless-bucket-bm12345"
#     Environment = var.ENV
#   }
# }

# resource "aws_ssm_parameter" "internal-team-bucket-param" {
#   name  = "internal-app-${var.ENV}-serverless-bucket"
#   type  = "String"
#   value = aws_s3_bucket.internal_team_serverless_bucket.id
# }

# # External Team Resources
# resource "aws_s3_bucket" "external_team_serverless_bucket" {
#   bucket = "external-team-serverless-bucket-bm98765"
#   acl    = "private"

#   tags = {
#     Name        = "external-team-serverless-bucket-bm98765"
#     Environment = var.ENV
#   }
# }

# resource "aws_ssm_parameter" "external-team-bucket-param" {
#   name  = "external-app-${var.ENV}-serverless-bucket"
#   type  = "String"
#   value = aws_s3_bucket.external_team_serverless_bucket.id
# }
