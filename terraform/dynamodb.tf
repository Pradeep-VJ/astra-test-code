resource "aws_dynamodb_table" "job_applications" {
  name         = "JobApplications"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "job_id"  # This is the partition key

  attribute {
    name = "job_id"
    type = "S"
  }

  # If "student" is required, it should be a sort key or an indexed attribute
  attribute {
    name = "student"
    type = "S"
  }

  # Optional: Add a global secondary index for student attribute if required
  global_secondary_index {
    name            = "StudentIndex"
    hash_key        = "student"
    projection_type = "ALL"
  }
}
