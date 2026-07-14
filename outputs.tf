output "github_action_role_arn" {
  value = module.security.github_action_role_arn
}

output "hugo_prod_bucket_id" {
  value = module.storage.hugo_prod_bucket_id
}

output "hugo_dev_bucket_id" {
  value = module.storage.hugo_dev_bucket_id
}

output "startpage_prod_bucket_id" {
  value = module.storage.startpage_prod_bucket_id
}

output "startpage_dev_bucket_id" {
  value = module.storage.startpage_dev_bucket_id
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

output "hugo_prod_cloudfront_dist_id" {
  value = module.network.hugo_prod_cloudfront_dist_id
}

output "hugo_dev_cloudfront_dist_id" {
  value = module.network.hugo_dev_cloudfront_dist_id
}

output "startpage_prod_cloudfront_dist_id" {
  value = module.network.startpage_prod_cloudfront_dist_id
}

output "startpage_dev_cloudfront_dist_id" {
  value = module.network.startpage_dev_cloudfront_dist_id
}

output "hugo_prod_cloudfront_url" {
  value = module.network.hugo_prod_cloudfront_domain_name
}

output "hugo_dev_cloudfront_url" {
  value = module.network.hugo_dev_cloudfront_domain_name
}

output "startpage_prod_cloudfront_url" {
  value = module.network.startpage_prod_cloudfront_domain_name
}

output "startpage_dev_cloudfront_url" {
  value = module.network.startpage_dev_cloudfront_domain_name
}
