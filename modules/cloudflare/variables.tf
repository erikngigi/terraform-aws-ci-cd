variable "hugo_name" {
  description = "Name of the Hugo website for resource tagging"
  type        = string
}

variable "startpage_name" {
  description = "Name of the Startpage website for resource tagging"
  type        = string
}

variable "domain_name" {
  description = "Domain name to use in filter options"
  type        = string
}

variable "hugo_subdomain_name" {
  description = "Subdomain for Hugo site (empty string for root domain)"
  type        = string
}

variable "hugo_www_subdomain_name" {
  description = "WWW subdomain for Hugo site"
  type        = string
}

variable "startpage_subdomain_name" {
  description = "Startpage subdomain name"
  type        = string
}

variable "hugo_cloudfront_domain_name" {
  description = "Name value of the Hugo cloudfront distribution"
  type        = string
}

variable "startpage_cloudfront_domain_name" {
  description = "Name value of the Startpage cloudfront distribution"
  type        = string
}

variable "hugo_acm_validation_options" {
  description = "ACM certificate validation DNS records for Hugo"
  type = list(object({
    name  = string
    type  = string
    value = string
  }))
}

variable "startpage_acm_validation_options" {
  description = "ACM certificate validation DNS records for Startpage"
  type = list(object({
    name  = string
    type  = string
    value = string
  }))
}
