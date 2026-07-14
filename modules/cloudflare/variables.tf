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

variable "hugo_prod_domain_name" {
  description = "Production domain name for Hugo webiste"
  type        = string
}

variable "hugo_dev_domain_name" {
  description = "Development domain name for Hugo website"
  type        = string
}

variable "startpage_prod_domain_name" {
  description = "Production domain name for the startpage"
  type        = string
}

variable "startpage_dev_domain_name" {
  description = "Development domain name for the startpage"
  type        = string
}

variable "hugo_prod_cloudfront_domain_name" {
  description = "Name value of the Hugo production cloudfront distribution"
  type        = string
}

variable "hugo_dev_cloudfront_domain_name" {
  description = "Name value of the Hugo development cloudfront distribution"
  type        = string
}

variable "startpage_prod_cloudfront_domain_name" {
  description = "Name value of the startpage production cloudfront distribution"
  type        = string
}

variable "startpage_dev_cloudfront_domain_name" {
  description = "Name value of the startpage development cloudfront distribution"
  type        = string
}

variable "hugo_prod_acm_validation_options" {
  description = "ACM certificate validation DNS records for Hugo production"
  type = list(object({
    name  = string
    type  = string
    value = string
  }))
}

variable "hugo_dev_acm_validation_options" {
  description = "ACM certificate validation DNS records for Hugo development"
  type = list(object({
    name  = string
    type  = string
    value = string
  }))
}

variable "startpage_prod_acm_validation_options" {
  description = "ACM certificate validation DNS records for the production startpage"
  type = list(object({
    name  = string
    type  = string
    value = string
  }))
}

variable "startpage_dev_acm_validation_options" {
  description = "ACM certificate validation DNS records for the development startpage"
  type = list(object({
    name  = string
    type  = string
    value = string
  }))
}
