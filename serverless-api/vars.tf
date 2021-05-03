variable "APP_NAME" {
  type        = string
  description = "Name of the application using the provisioned resources"
}

variable "ENV" {}

variable "PATH_TO_ARTIFACT" {
  type        = string
  description = "Path to the packaged lambda function to upload to S3."
}
