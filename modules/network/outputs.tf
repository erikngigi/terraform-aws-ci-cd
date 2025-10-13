output "cloudfront_distribution_arn" {
  description = "Resource output for the cloudfront distribution arn"
  value       = aws_cloudfront_distribution.hugo_site.arn
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  value       = aws_cloudfront_distribution.hugo_site.id
}

output "cloudfront_domain_name" {
  description = "CloudFront distribution URL (HTTPS)"
  value       = aws_cloudfront_distribution.hugo_site.domain_name
}

output "acm_validation_options" {
  description = "ACM certificate validation DNS records"
  value = [
    for dvo in aws_acm_certificate.hugo_site.domain_validation_options : {
      name  = dvo.resource_record_name
      type  = dvo.resource_record_type
      value = dvo.resource_record_value
    }
  ]
}
