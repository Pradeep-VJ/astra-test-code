provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_role" "job_application_lambda_role" {
  name = "job-application-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "lambda_policy" {
  name        = "job-application-lambda-policy"
  description = "IAM policy for Lambda function to access S3, SNS, and Logs"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "s3:GetObject",
          "s3:ListBucket",
          "s3:PutObject"
        ]
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = [
          "sns:Publish",
          "sns:Subscribe"
        ]
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.job_application_lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

resource "aws_lambda_function" "job_application_lambda" {
  function_name    = "ApplyJobsLambda"
  role            = aws_iam_role.job_application_lambda_role.arn
  handler         = "lambda_function.lambda_handler"
  runtime         = "python3.8"
  memory_size     = 128
  timeout         = 3
  package_type    = "Zip"
  filename        = "lambda_package.zip"  # Ensure this file exists before running Terraform

  environment {
    variables = {
      LOG_LEVEL = "INFO" # Example variable; you can add more
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.lambda_policy_attachment
  ]
}
