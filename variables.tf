# Main details
# Project details
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

variable "git_oidc_thumbprint_list" {
  description = "List of thumbprints for the GitHub OIDC provider"
  type        = list(string)
}

# Cloudflare details
variable "domain_name" {
  description = "Domain name to use in filter options"
  type        = string
}

variable "subdomain_name" {
  description = "Subdomain for the Hugo website"
  type        = string
}

# Security details
variable "git_oidc_url" {
  description = "GitHub actions OIDC url"
  type        = string
}
