resource "aws_s3_bucket" "hugo_prod_site" {
  bucket        = "${var.hugo_name}-s3-prod"
  force_destroy = true

  tags = {
    Name = "${var.hugo_name}-s3-prod"
  }
}

resource "aws_s3_bucket" "hugo_dev_site" {
  bucket        = "${var.hugo_name}-s3-dev"
  force_destroy = true

  tags = {
    Name = "${var.hugo_name}-s3-dev"
  }
}

resource "aws_s3_bucket" "startpage_site" {
  bucket        = "${var.startpage_name}-s3-bucket"
  force_destroy = true

  tags = {
    Name = "${var.startpage_name}-s3-bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "hugo_prod_site" {
  bucket                  = aws_s3_bucket.hugo_prod_site.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "hugo_dev_site" {
  bucket                  = aws_s3_bucket.hugo_dev_site.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "startpage_site" {
  bucket = aws_s3_bucket.startpage_site.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "hugo_prod_site" {
  bucket = aws_s3_bucket.hugo_prod_site.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "hugo_dev_site" {
  bucket = aws_s3_bucket.hugo_dev_site.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "startpage_site" {
  bucket = aws_s3_bucket.startpage_site.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_policy" "hugo_prod_site" {
  bucket = aws_s3_bucket.hugo_prod_site.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCloudFrontServicePrincipal"
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.hugo_prod_site.arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = var.hugo_prod_cloudfront_dist_arn
          }
        }
      }
    ]
  })
}

resource "aws_s3_bucket_policy" "hugo_dev_site" {
  bucket = aws_s3_bucket.hugo_dev_site.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCloudFrontServicePrincipal"
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.hugo_dev_site.arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = var.hugo_dev_cloudfront_dist_arn
          }
        }
      }
    ]
  })
}

resource "aws_s3_bucket_policy" "startpage_site" {
  bucket = aws_s3_bucket.startpage_site.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCloudFrontServicePrincipal"
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.startpage_site.arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = var.startpage_cloudfront_dist_arn
          }
        }
      }
    ]
  })
}
