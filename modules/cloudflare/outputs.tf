output "cloudflare_zones_name" {
  description = "Resource output of the domain name filtered result"
  value       = [for z in data.cloudflare_zones.zone.result : z.name]
}

output "cloudflare_zone_id" {
  description = "Resource output of the domain name zone id"
  value       = [for z in data.cloudflare_zones.zone.result : z.id]
}

output "cloudflare_dns_records" {
  description = "Resource output of the dns records in the domain"
  value = [
    for z in data.cloudflare_dns_records.all.result : z.name
    if z.name != var.domain_name
  ]
}
