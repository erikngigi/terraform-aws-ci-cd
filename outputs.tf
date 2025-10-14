output "github_action_role_arn" {
  description = "ARN of the IAM role for GitHub Actions"
  value       = module.security.github_action_role_arn
}

output "s3_bucket_name" {
  description = "Name of the s3 bucket"
  value       = module.storage.s3_bucket_name
}

# output "cloudflare_zone_names" {
#   description = "Filtered domain name for Cloudflare module"
#   value       = module.cloudflare.cloudflare_zones_name
# }

# output "cloudflare_zone_id" {
#   description = "Resource output of the domain name zone id"
#   value       = module.cloudflare.cloudflare_zone_id
# }

# output "cloudflare_dns_records" {
#   description = "Resource output of the dns records in the domain"
#   value       = module.cloudflare.cloudflare_dns_records
# }

# output "cloudflare_hugo_url" {
#   value = "https://${module.cloudflare.cloudflare_hugo_url}"
# }

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  value       = module.network.cloudfront_distribution_id
}

# output "cloudfront_url" {
#   description = "CloudFront distribution URL (HTTPS)"
#   value       = "https://${module.network.cloudfront_domain_name}"
# }
