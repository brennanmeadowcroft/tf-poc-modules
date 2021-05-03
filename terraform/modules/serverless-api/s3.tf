resource "aws_s3_bucket" "artifact_bucket" {
  bucket = "${var.APP_NAME}-serverless-bucket-bm12345"
  acl    = "private"

  tags = {
    Name        = "${var.APP_NAME}-serverless-bucket-bm12345"
    Environment = var.ENV
  }
}

resource "aws_ssm_parameter" "artifact_bucket_param" {
  name  = "${var.APP_NAME}-${var.ENV}-serverless-bucket"
  type  = "String"
  value = aws_s3_bucket.artifact_bucket.id
}
