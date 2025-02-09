variable "AWS_REGION" {
  description = "AWS region where resources will be created"
  default     = "us-east-1" # Change this if needed
}

variable "AWS_ACCESS_KEY_ID" {
  description = "AWS Access Key"
  type        = string
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS Secret Key"
  type        = string
}
