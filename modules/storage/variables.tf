variable "hugo_name" {
  description = "Name of the Hugo website for resource tagging"
  type        = string
}

variable "startpage_name" {
  description = "Name of the Startpage website for resource tagging"
  type        = string
}

variable "hugo_cloudfront_dist_arn" {
  description = "ARN value of the Hugo cloudfront distribution"
  type        = string
}

variable "startpage_cloudfront_dist_arn" {
  description = "ARN value of the Startpage cloudfront distribution"
  type        = string
}
