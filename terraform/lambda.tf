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
