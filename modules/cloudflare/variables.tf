variable "domain_name" {
  description = "Domain name to use in filter options"
  type        = string
}

variable "subdomain_name" {
  description = "Subdomain name to apply to cloudfront url"
  type        = string
}

variable "cloudfront_url" {
  description = "Generated website url from cloudfront network module"
  type        = string
}

variable "acm_validation_options" {
  description = "ACM certificate validation options from network module"
  type = list(object({
    name  = string
    type  = string
    value = string
  }))
}
