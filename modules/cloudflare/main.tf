data "cloudflare_zones" "zone" {
  name = var.domain_name
}

data "cloudflare_dns_records" "all" {
  zone_id = data.cloudflare_zones.zone.result[0].id
}

resource "cloudflare_dns_record" "hugo_prod_acm_validation" {
  for_each = {
    for idx, record in var.hugo_prod_acm_validation_options : idx => record
  }

  zone_id = data.cloudflare_zones.zone.result[0].id
  name    = trimsuffix(each.value.name, ".")
  type    = each.value.type
  content = trimsuffix(each.value.value, ".")
  ttl     = 60
  proxied = false
  comment = "ACM certificate validation for ${var.hugo_prod_domain_name}.${var.domain_name}"
}

resource "cloudflare_dns_record" "hugo_dev_acm_validation" {
  for_each = {
    for idx, record in var.hugo_dev_acm_validation_options : idx => record
  }

  zone_id = data.cloudflare_zones.zone.result[0].id
  name    = trimsuffix(each.value.name, ".")
  type    = each.value.type
  content = trimsuffix(each.value.value, ".")
  ttl     = 60
  proxied = false
  comment = "ACM certificate validation for ${var.hugo_dev_domain_name}.${var.domain_name}"
}

resource "cloudflare_dns_record" "startpage_prod_acm_validation" {
  for_each = {
    for idx, record in var.startpage_prod_acm_validation_options : idx => record
  }

  zone_id = data.cloudflare_zones.zone.result[0].id
  name    = trimsuffix(each.value.name, ".")
  type    = each.value.type
  content = trimsuffix(each.value.value, ".")
  ttl     = 60
  proxied = false
  comment = "ACM certificate validation for ${var.startpage_prod_domain_name}.${var.domain_name}"
}

resource "cloudflare_dns_record" "startpage_dev_acm_validation" {
  for_each = {
    for idx, record in var.startpage_dev_acm_validation_options : idx => record
  }

  zone_id = data.cloudflare_zones.zone.result[0].id
  name    = trimsuffix(each.value.name, ".")
  type    = each.value.type
  content = trimsuffix(each.value.value, ".")
  ttl     = 60
  proxied = false
  comment = "ACM certificate validation for ${var.startpage_dev_domain_name}.${var.domain_name}"
}

resource "cloudflare_dns_record" "hugo_prod_site" {
  zone_id    = data.cloudflare_zones.zone.result[0].id
  name       = var.hugo_prod_domain_name
  ttl        = 60
  type       = "CNAME"
  content    = var.hugo_prod_cloudfront_domain_name
  proxied    = false
  comment    = "production hugo website (cloud-journal) from cloudfront"
  depends_on = [cloudflare_dns_record.hugo_prod_acm_validation]
}

resource "cloudflare_dns_record" "hugo_dev_site" {
  zone_id    = data.cloudflare_zones.zone.result[0].id
  name       = var.hugo_dev_domain_name
  ttl        = 60
  type       = "CNAME"
  content    = var.hugo_dev_cloudfront_domain_name
  proxied    = false
  comment    = "development hugo website (cloud-journal) from cloudfront"
  depends_on = [cloudflare_dns_record.hugo_dev_acm_validation]
}

resource "cloudflare_dns_record" "startpage_prod_site" {
  zone_id    = data.cloudflare_zones.zone.result[0].id
  name       = var.startpage_prod_domain_name
  ttl        = 60
  type       = "CNAME"
  content    = var.startpage_prod_cloudfront_domain_name
  proxied    = false
  comment    = "production startpage from aws cloudfront"
  depends_on = [cloudflare_dns_record.startpage_prod_acm_validation]
}

resource "cloudflare_dns_record" "startpage_dev_site" {
  zone_id    = data.cloudflare_zones.zone.result[0].id
  name       = var.startpage_dev_domain_name
  ttl        = 60
  type       = "CNAME"
  content    = var.startpage_dev_cloudfront_domain_name
  proxied    = false
  comment    = "development startpage from aws cloudfront"
  depends_on = [cloudflare_dns_record.startpage_dev_acm_validation]
}

