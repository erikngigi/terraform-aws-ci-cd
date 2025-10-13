variable "project_name" {
  description = "Project name used for resource tagging"
  type        = string
}

variable "cloudfront_distribution_arn" {
  description = "Cloudfront Distribution ARN from the network module"
  type        = string
}
