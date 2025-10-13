resource "aws_cloudfront_origin_access_control" "hugo_site" {
  name                              = "${var.s3_bucket_name}-oac"
  description                       = "OAC for the hugo site"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# CloudFront Function to handle clean URLs
resource "aws_cloudfront_function" "url_rewrite" {
  name    = "hugo-url-rewrite"
  runtime = "cloudfront-js-2.0"
  comment = "Rewrite URLs to add index.html for Hugo"
  publish = true
  code    = <<-EOT
function handler(event) {
    var request = event.request;
    var uri = request.uri;
    
    // Check whether the URI is missing a file name
    if (uri.endsWith('/')) {
        request.uri += 'index.html';
    } 
    // Check whether the URI is missing a file extension
    else if (!uri.includes('.')) {
        request.uri += '/index.html';
    }
    
    return request;
}
EOT
}

resource "aws_cloudfront_distribution" "hugo_site" {
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  price_class         = "PriceClass_100"
  comment             = "Hugo site distribution"
  http_version        = "http2and3"

  aliases = ["${var.subdomain_name}.${var.domain_name}"]

  origin {
    domain_name              = var.s3_bucket_regional_domain_name
    origin_id                = "S3-${var.s3_bucket_name}"
    origin_access_control_id = aws_cloudfront_origin_access_control.hugo_site.id
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${var.s3_bucket_name}"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    function_association {
      event_type   = "viewer-request"
      function_arn = aws_cloudfront_function.url_rewrite.arn
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
    acm_certificate_arn      = aws_acm_certificate.hugo_site.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  tags = {
    Name = "Hugo Site Distribution"
  }
}

resource "aws_acm_certificate" "hugo_site" {
  # provider          = aws.us_east_1
  domain_name       = "${var.subdomain_name}.${var.domain_name}"
  validation_method = "DNS"
  key_algorithm     = "EC_prime256v1"

  options {
    certificate_transparency_logging_preference = "ENABLED"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "Hugo Site Certificate"
  }
}
