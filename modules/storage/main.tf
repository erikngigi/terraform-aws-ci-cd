resource "aws_s3_bucket" "hugo_site" {
  bucket = "${var.project_name}-stack-theme-s3"

  tags = {
    Name = "Hugo Theme Stack Site"
  }
}

resource "aws_s3_bucket_public_access_block" "hugo_site" {
  bucket = aws_s3_bucket.hugo_site.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "hugo_site" {
  bucket = aws_s3_bucket.hugo_site.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
