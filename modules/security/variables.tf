variable "hugo_name" {
  description = "Name of the Hugo website for resource tagging"
  type        = string
}

variable "startpage_name" {
  description = "Name of the Startpage website for resource tagging"
  type        = string
}

variable "github_org" {
  description = "GitHub organization or username"
  type        = string
}

variable "github_hugo_repo" {
  description = "Hugo GitHub repository name"
  type        = string
}

variable "github_startpage_repo" {
  description = "Startpage GitHub repository name"
  type        = string
}

# Security details
variable "github_oidc_url" {
  description = "GitHub actions OIDC url"
  type        = string
}

# Storage details
variable "hugo_prod_bucket_arn" {
  description = "ARN value of the Hugo production S3 bucket"
  type        = string
}

variable "hugo_dev_bucket_arn" {
  description = "ARN value of the Hugo development S3 bucket"
  type        = string
}

variable "startpage_prod_bucket_arn" {
  description = "ARN value of the startpage production S3 bucket"
  type        = string
}

variable "startpage_dev_bucket_arn" {
  description = "ARN value of the startpage development S3 bucket"
  type        = string
}

# Network details
variable "hugo_prod_cloudfront_dist_arn" {
  description = "ARN value of the Hugo production cloudfront distribution"
  type        = string
}

variable "hugo_dev_cloudfront_dist_arn" {
  description = "ARN value of the Hugo development cloudfront distribution"
  type        = string
}

variable "startpage_prod_cloudfront_dist_arn" {
  description = "ARN value of the startpage production cloudfront distribution"
  type        = string
}

variable "startpage_dev_cloudfront_dist_arn" {
  description = "ARN value of the startpage development cloudfront distribution"
  type        = string
}
