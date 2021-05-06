variable "AWS_REGION" {
  default = "us-west-2"
}
variable "APP_NAME" {
  type        = string
  description = "Name of the application using the provisioned resources"
}

variable "ARTIFACT_S3_KEY" {}

variable "ENV" {}

variable "PATH_TO_ARTIFACT" {
  type        = string
  description = "Path to the packaged lambda function to upload to S3."
}

variable "ENVIRONMENT_VARS" {
  description = "Environment variables to pass into Lambda function"
  default = {
    placeholder = "true" # Lambda environment block requires at least one item
  }
}
