resource "aws_s3_bucket" "new_bucket" {
  bucket = var.new_bucket  

}

resource "aws_s3_bucket_ownership_controls" "new_bucket_ownership" {
  bucket = aws_s3_bucket.new_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "name" {
  bucket = aws_s3_bucket.new_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.encryption_algorithm
    }
  }
}