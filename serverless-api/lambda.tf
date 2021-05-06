data "aws_ssm_parameter" "lambda_exec_role" {
  name = "infra-roles-lambda-exec-role-12345"
}
resource "aws_s3_bucket_object" "build_artifact" {
  bucket = aws_s3_bucket.artifact_bucket.id
  key    = var.ARTIFACT_S3_KEY
  source = var.PATH_TO_ARTIFACT
}

resource "aws_lambda_function" "handler" {
  function_name = var.APP_NAME

  s3_bucket = aws_s3_bucket.artifact_bucket.id
  s3_key    = aws_s3_bucket_object.build_artifact.id

  handler = "src/main.handler"

  runtime = "nodejs10.x"
  role    = data.aws_ssm_parameter.lambda_exec_role.value

  environment {
    variables = var.ENVIRONMENT_VARS
  }
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.handler.function_name
  principal     = "apigateway.amazonaws.com"

  # The "/*/*" portion grants access from any method on any resource
  # within the API Gateway REST API.
  source_arn = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}

output "build_artifact" {
  value = "${aws_s3_bucket.artifact_bucket.id}/${aws_s3_bucket_object.build_artifact.id}"
}
