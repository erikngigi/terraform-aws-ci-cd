variable "hugo_name" {
  description = "Name of the Hugo website for resource tagging"
  type        = string
}

variable "startpage_name" {
  description = "Name of the Startpage website for resource tagging"
  type        = string
}

variable "hugo_bucket_id" {
  description = "ID value of the Hugo S3 bucket (storage module)"
  type        = string
}

variable "startpage_bucket_id" {
  description = "ID value of the Startpage S3 bucket (storage module)"
  type        = string
}

variable "hugo_bucket_domain_name" {
  description = "Bucket domain name of the Hugo S3 bucket (storage module)"
  type        = string
}

variable "startpage_bucket_domain_name" {
  description = "Bucket domain name of the Startpage S3 bucket (storage module)"
  type        = string
}

variable "domain_name" {
  description = "Domain name"
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
