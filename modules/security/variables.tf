variable "project_name" {
  description = "Project name used for resource tagging"
  type        = string
}

variable "github_org" {
  description = "GitHub organization or username"
  type        = string
}

variable "github_repo" {
  description = "Github repository name"
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
variable "hugo_s3_bucket_arn" {
  description = "ARN value of the hugo s3 bucket from storage module"
  type        = string
}

# Network details
variable "cloudfront_distribution_arn" {
  description = "Cloudfront Distribution ARN from the network module"
  type        = string
}
