variable "hugo_name" {
  description = "Name of the Hugo website for resource tagging"
  type        = string
}

variable "startpage_name" {
  description = "Name of the Startpage website for resource tagging"
  type        = string
}

variable "hugo_bucket_prod_id" {
  description = "ID value of the Hugo production S3 bucket (storage module)"
  type        = string
}

variable "hugo_bucket_dev_id" {
  description = "ID value of the Hugo development S3 bucket (storage module)"
  type        = string
}

variable "startpage_bucket_prod_id" {
  description = "ID value of the Startpage production S3 bucket (storage module)"
  type        = string
}

variable "startpage_bucket_dev_id" {
  description = "ID value of the Startpage development S3 bucket (storage module)"
  type        = string
}

variable "hugo_bucket_prod_domain_name" {
  description = "S3 bucket domain name for Hugo production site (storage module)"
  type        = string
}

variable "hugo_bucket_dev_domain_name" {
  description = "S3 bucket domain name for Hugo development site (storage module)"
  type        = string
}

variable "startpage_bucket_prod_domain_name" {
  description = "S3 bucket domain name of the static development startpage (storage module)"
  type        = string
}

variable "startpage_bucket_dev_domain_name" {
  description = "S3 bucket domain name of the static production startpage (storage module)"
  type        = string
}

variable "domain_name" {
  description = "Domain name"
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
  description = "Production domain name for static startpage"
  type        = string
}

variable "startpage_dev_domain_name" {
  description = "Development domain name for static startpage"
  type        = string
}
