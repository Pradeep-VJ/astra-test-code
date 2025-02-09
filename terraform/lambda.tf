resource "aws_lambda_function" "job_application_lambda" {
  function_name    = "job-application-lambda"
  role            = aws_iam_role.job_application_lambda_role.arn
  handler         = "lambda_function.lambda_handler"
  runtime         = "python3.9"
  filename        = "lambda_package.zip"
  source_code_hash = filebase64sha256("lambda_package.zip")

  environment {
    variables = {
      ENV = "Production"
    }
  }
}

resource "aws_iam_role" "job_application_lambda_role" {
  name               = "job-application-lambda-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })

  lifecycle {
    ignore_changes = [assume_role_policy]
  }

  tags = {
    Name        = "Job Application Lambda Role"
    Environment = "Production"
  }
}

resource "aws_lambda_permission" "allow_s3_trigger" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.job_application_lambda.function_name
  principal     = "s3.amazonaws.com"
}
