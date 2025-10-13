variable "s3_bucket_name" {
  description = "Name of the s3 hugo bucket"
  type        = string
}

variable "s3_bucket_regional_domain_name" {
  description = "Domain name of the s3 hugo bucket"
  type        = string
}

variable "domain_name" {
  description = "Domain name"
  type        = string
}

variable "subdomain_name" {
  description = "Subdomain name"
  type        = string
}
