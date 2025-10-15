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


variable "hugo_subdomain_name" {
  description = "Hugo subdomain name"
  type        = string
}

variable "startpage_subdomain_name" {
  description = "Startpage subdomain name"
  type        = string
}

# Security details
variable "git_oidc_url" {
  description = "GitHub actions OIDC url"
  type        = string
}

variable "git_oidc_thumbprint_list" {
  description = "List of thumbprints for the GitHub OIDC provider"
  type        = list(string)
}

# Storage details
variable "hugo_bucket_arn" {
  description = "ARN value of the Hugo S3 bucket"
  type        = string
}

variable "startpage_bucket_arn" {
  description = "ARN value of the Startpage S3 bucket"
  type        = string
}

# Network details
variable "hugo_cloudfront_dist_arn" {
  description = "ARN value of the Hugo cloudfront distribution"
  type        = string
}

variable "startpage_cloudfront_dist_arn" {
  description = "ARN value of the Startpage cloudfront distribution"
  type        = string
}
