resource "aws_lambda_function" "job_application_lambda" {
  function_name = "ApplyJobsLambda"
  role          = aws_iam_role.lambda_role.arn
  runtime       = "python3.9"
  handler       = "apply_jobs.lambda_handler"
  filename      = "../lambda/build.zip"
  memory_size   = 3072
  timeout       = 900
}
