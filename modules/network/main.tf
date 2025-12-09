resource "aws_cloudfront_origin_access_control" "hugo_prod_site" {
  name                              = "${var.hugo_bucket_prod_id}-oac"
  description                       = "Hugo production website origin access control"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_origin_access_control" "hugo_dev_site" {
  name                              = "${var.hugo_bucket_dev_id}-oac"
  description                       = "Hugo development webiste origin access control"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_origin_access_control" "startpage_site" {
  name                              = "${var.startpage_bucket_id}-oac"
  description                       = "Startpage website origin access control"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# CloudFront Function to handle clean URLs
resource "aws_cloudfront_function" "hugo_url_rewrite" {
  name    = "hugo-url-rewrite"
  runtime = "cloudfront-js-2.0"
  comment = "Rewrite URLs to add index.html for Hugo"
  publish = true
  code    = file("${path.module}/functions/hugo_url_rewrite.js")
}

resource "aws_cloudfront_function" "startpage_url_rewrite" {
  name    = "startpage-url-rewrite"
  runtime = "cloudfront-js-2.0"
  comment = "Rewrite URLs to add index.html for Startpage"
  publish = true
  code    = file("${path.module}/functions/startpage_url_rewrite.js")
}

resource "aws_acm_certificate" "hugo_prod_site" {
  domain_name       = "${var.hugo_prod_domain_name}.${var.domain_name}"
  validation_method = "DNS"
  key_algorithm     = "EC_prime256v1"

  options {
    certificate_transparency_logging_preference = "ENABLED"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "Hugo Production Website Certificate"
  }
}

resource "aws_acm_certificate" "hugo_dev_site" {
  domain_name       = "${var.hugo_dev_domain_name}.${var.domain_name}"
  validation_method = "DNS"
  key_algorithm     = "EC_prime256v1"

  options {
    certificate_transparency_logging_preference = "ENABLED"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "Hugo Development Website Certificate"
  }
}

resource "aws_acm_certificate" "startpage_site" {
  domain_name       = "${var.startpage_subdomain_name}.${var.domain_name}"
  validation_method = "DNS"
  key_algorithm     = "EC_prime256v1"

  options {
    certificate_transparency_logging_preference = "ENABLED"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "Startpage Website Certificate"
  }
}

resource "aws_cloudfront_distribution" "hugo_prod_site" {
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  price_class         = "PriceClass_100"
  comment             = "Hugo website distribution"
  http_version        = "http2and3"

  aliases = ["${var.hugo_prod_domain_name}.${var.domain_name}"]

  origin {
    domain_name              = var.hugo_bucket_prod_domain_name
    origin_id                = "S3-${var.hugo_bucket_prod_id}"
    origin_access_control_id = aws_cloudfront_origin_access_control.hugo_prod_site.id
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${var.hugo_bucket_prod_id}"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    function_association {
      event_type   = "viewer-request"
      function_arn = aws_cloudfront_function.hugo_url_rewrite.arn
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
  }

  custom_error_response {
    error_code         = 404
    response_code      = 404
    response_page_path = "/404.html"
  }

  custom_error_response {
    error_code         = 403
    response_code      = 404
    response_page_path = "/404.html"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.hugo_prod_site.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  tags = {
    Name = "Hugo Website Distribution"
  }
}

resource "aws_cloudfront_distribution" "hugo_dev_site" {
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  price_class         = "PriceClass_100"
  comment             = "Hugo website distribution"
  http_version        = "http2and3"

  aliases = ["${var.hugo_dev_domain_name}.${var.domain_name}"]

  origin {
    domain_name              = var.hugo_bucket_dev_domain_name
    origin_id                = "S3-${var.hugo_bucket_dev_id}"
    origin_access_control_id = aws_cloudfront_origin_access_control.hugo_dev_site.id
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${var.hugo_bucket_dev_id}"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    function_association {
      event_type   = "viewer-request"
      function_arn = aws_cloudfront_function.hugo_url_rewrite.arn
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
  }

  custom_error_response {
    error_code         = 404
    response_code      = 404
    response_page_path = "/404.html"
  }

  custom_error_response {
    error_code         = 403
    response_code      = 404
    response_page_path = "/404.html"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.hugo_dev_site.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  tags = {
    Name = "Hugo Website Distribution"
  }
}

resource "aws_cloudfront_distribution" "startpage_site" {
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  price_class         = "PriceClass_100"
  comment             = "Startpage website distribution"
  http_version        = "http2and3"

  aliases = ["${var.startpage_subdomain_name}.${var.domain_name}"]

  origin {
    domain_name              = var.startpage_bucket_domain_name
    origin_id                = "S3-${var.startpage_bucket_id}"
    origin_access_control_id = aws_cloudfront_origin_access_control.startpage_site.id
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${var.startpage_bucket_id}"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    function_association {
      event_type   = "viewer-request"
      function_arn = aws_cloudfront_function.startpage_url_rewrite.arn
    }


    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
  }

  custom_error_response {
    error_code         = 404
    response_code      = 404
    response_page_path = "/404.html"
  }

  custom_error_response {
    error_code         = 403
    response_code      = 404
    response_page_path = "/404.html"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.startpage_site.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  tags = {
    Name = "Startpage Website Distribution"
  }
}
