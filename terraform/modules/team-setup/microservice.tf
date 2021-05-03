variable "APP_NAME" {
  type        = string
  description = "Name of the application using the provisioned resources"
}

variable "ENV" {}

resource "aws_s3_bucket" "serverless_bucket" {
  bucket = "${var.APP_NAME}-serverless-bucket-bm12345"
  acl    = "private"

  tags = {
    Name        = "${var.APP_NAME}-serverless-bucket-bm12345"
    Environment = var.ENV
  }
}

resource "aws_ssm_parameter" "serverless_bucket_param" {
  name  = "${var.APP_NAME}-${var.ENV}-serverless-bucket"
  type  = "String"
  value = aws_s3_bucket.serverless_bucket.id
}
