resource "aws_lambda_function" "job_application_lambda" {
  function_name    = "job-application-lambda"
  role            = aws_iam_role.job_application_lambda_role.arn
  runtime         = "python3.9"
  handler         = "apply_jobs.lambda_handler"
  filename        = "lambda_package.zip"
  source_code_hash = filebase64sha256("lambda_package.zip")
  timeout         = 10

  environment {
    variables = {
      DYNAMO_TABLE_NAME = aws_dynamodb_table.job_applications.name
    }
  }

  tags = {
    Name        = "Job Application Lambda"
    Environment = "Production"
  }
}
