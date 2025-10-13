data "cloudflare_zones" "zone" {
  name = var.domain_name
}

data "cloudflare_dns_records" "all" {
  zone_id = data.cloudflare_zones.zone.result[0].id
}

resource "cloudflare_dns_record" "acm_validation" {
  for_each = {
    for idx, record in var.acm_validation_options : idx => record
  }

  zone_id = data.cloudflare_zones.zone.result[0].id
  name    = trimsuffix(each.value.name, ".")
  type    = each.value.type
  content = trimsuffix(each.value.value, ".")
  ttl     = 60
  proxied = false

  comment = "ACM certificate validation for ${var.subdomain_name}.${var.domain_name}"
}

resource "cloudflare_dns_record" "hugo_site" {
  zone_id = data.cloudflare_zones.zone.result[0].id
  name    = var.subdomain_name
  ttl     = 1
  type    = "CNAME"
  content = var.cloudfront_url
  proxied = true

  comment = "Hugo site on CloudFront with Cloudflare SSL"

  depends_on = [cloudflare_dns_record.acm_validation]
}
