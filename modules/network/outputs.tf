output "hugo_cloudfront_dist_arn" {
  description = "ARN value of the Hugo cloudfront distribution"
  value       = aws_cloudfront_distribution.hugo_site.arn
}

output "startpage_cloudfront_dist_arn" {
  description = "ARN value of the Startpage cloudfront distribution"
  value       = aws_cloudfront_distribution.startpage_site.arn
}

output "hugo_cloudfront_dist_id" {
  description = "ID value of the Hugo cloudfront distribution"
  value       = aws_cloudfront_distribution.hugo_site.id
}

output "startpage_cloudfront_dist_id" {
  description = "ID value of the Startpage cloudfront distribution"
  value       = aws_cloudfront_distribution.startpage_site.id
}

output "hugo_cloudfront_domain_name" {
  description = "Name value of the Hugo cloudfront distribution"
  value       = aws_cloudfront_distribution.hugo_site.domain_name
}

output "startpage_cloudfront_domain_name" {
  description = "Name value of the Startpage cloudfront distribution"
  value       = aws_cloudfront_distribution.startpage_site.domain_name
}

output "hugo_acm_validation_options" {
  description = "ACM certificate validation DNS records for Hugo"
  value = [
    for dvo in aws_acm_certificate.hugo_site.domain_validation_options : {
      name  = dvo.resource_record_name
      type  = dvo.resource_record_type
      value = dvo.resource_record_value
    }
  ]
}

output "startpage_acm_validation_options" {
  description = "ACM certificate validation DNS records for Startpage"
  value = [
    for dvo in aws_acm_certificate.startpage_site.domain_validation_options : {
      name  = dvo.resource_record_name
      type  = dvo.resource_record_type
      value = dvo.resource_record_value
    }
  ]
}
