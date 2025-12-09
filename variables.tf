# Main details
# Project details
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

# Cloudflare details
variable "domain_name" {
  description = "Owned domain name"
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

variable "startpage_subdomain_name" {
  description = "Startpage subdomain name"
  type        = string
}

# Security details
variable "github_oidc_url" {
  description = "GitHub actions OIDC url"
  type        = string
}
