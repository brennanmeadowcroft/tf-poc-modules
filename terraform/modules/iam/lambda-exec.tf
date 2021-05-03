variable "LAMBDA_EXEC_ROLE_NAME" {
  default = "lambda-exec-role"
}

resource "aws_iam_role" "lambda-execution-role" {
  name = var.LAMBDA_EXEC_ROLE_NAME

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Effect" : "Allow",
        "Sid" : ""
      }
    ]
  })
}

output "lambda-execution-role-arn" {
  description = "The ARN of the lambda execution role"
  value       = aws_iam_role.lambda-execution-role.arn
}

resource "aws_ssm_parameter" "lambda-execution-role-arn-param" {
  name  = "infra-roles-${var.LAMBDA_EXEC_ROLE_NAME}"
  type  = "String"
  value = aws_iam_role.lambda-execution-role.arn
}
