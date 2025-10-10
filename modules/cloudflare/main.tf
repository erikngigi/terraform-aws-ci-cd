data "cloudflare_zones" "zone" {
  name = var.domain_name
}

data "cloudflare_dns_records" "all" {
  zone_id = data.cloudflare_zones.zone.result[0].id
}
