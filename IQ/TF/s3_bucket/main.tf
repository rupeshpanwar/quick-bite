resource "aws_s3_bucket" "my_bucket" {
  count  = length(var.bucket_name)
  bucket = var.bucket_name[count.index]
  acl    = "private"

  tags = {
    Name        = "Bucket ${count.index + 1}"
    Environment = var.environment
  }
}


resource "aws_s3_bucket_acl" "my_bucket_acl" {
  bucket = aws_s3_bucket.my_bucket.id

  acl = "private"
}



