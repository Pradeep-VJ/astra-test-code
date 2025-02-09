resource "aws_lambda_function" "job_application_lambda" {
  function_name = "ApplyJobsLambda"
  role          = aws_iam_role.lambda_role.arn  # Now correctly referencing the IAM role
  runtime       = "python3.8"
  handler       = "lambda_function.lambda_handler"
  
  filename         = "lambda_package.zip"
  source_code_hash = filebase64sha256("lambda_package.zip")

  environment {
    variables = {
      AWS_ACCESS_KEY_ID     = var.AWS_ACCESS_KEY_ID
      AWS_SECRET_ACCESS_KEY = var.AWS_SECRET_ACCESS_KEY
    }
  }
}
