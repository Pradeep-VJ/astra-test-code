resource "aws_dynamodb_table" "job_applications" {
  name           = "JobApplications"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "job_id"

  attribute {
    name = "job_id"
    type = "S"
  }

  attribute {
    name = "student"
    type = "S"
  }
}
