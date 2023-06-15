terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0"
    }
  }

  backend "s3" {
    bucket = "dcp-s3-test-bucket-tf-dev"
    key    = "terraform.tfstate"
    region = "ap-southeast-1"
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

module "s3_bucket" {
  source = "./s3_bucket"
  # version = "1.0.0"

  bucket_name = var.bucket_name
  environment = var.environment
  workspace   = var.workspace
}



