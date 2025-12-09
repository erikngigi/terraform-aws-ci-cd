output "github_action_role_arn" {
  description = "ARN of the IAM role for GitHub Actions"
  value       = module.security.github_action_role_arn
}

output "hugo_bucket_id" {
  description = "ID value of the Hugo S3 bucket"
  value       = module.storage.hugo_bucket_id
}

output "startpage_bucket_id" {
  description = "ID value of the Startpage S3 bucket"
  value       = module.storage.startpage_bucket_id
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

output "hugo_cloudfront_dist_id" {
  description = "ID value of the Hugo Cloudfront Distribution"
  value       = module.network.hugo_cloudfront_dist_id
}

output "startpage_cloudfront_dist_id" {
  description = "ID value of the Startpage Cloudfront Distribution"
  value       = module.network.startpage_cloudfront_dist_id
}

output "cloudfront_url" {
  description = "CloudFront distribution URL (HTTPS)"
  value       = module.network.hugo_cloudfront_domain_name
}
