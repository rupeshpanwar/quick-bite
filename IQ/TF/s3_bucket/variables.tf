variable "bucket_name" {
  description = "List of S3 bucket names"
  type        = list(string)
}

variable "environment" {
  description = "Environment for the S3 bucket"
  type        = string
}


variable "workspace" {
  description = "Terraform workspace name"
  type        = string
}


# variable "aws_access_key" {}

# variable "aws_secret_key" {}

