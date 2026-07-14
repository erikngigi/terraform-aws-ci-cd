variable "hugo_name" {
  description = "Name of the Hugo website for resource tagging"
  type        = string
}

variable "startpage_name" {
  description = "Name of the Startpage website for resource tagging"
  type        = string
}

variable "hugo_prod_cloudfront_dist_arn" {
  description = "ARN value of the Hugo production cloudfront distribution"
  type        = string
}

variable "hugo_dev_cloudfront_dist_arn" {
  description = "ARN value of the Hugo development cloudfront distribution"
  type        = string
}

variable "startpage_prod_cloudfront_dist_arn" {
  description = "ARN value of the production startpage cloudfront distribution"
  type        = string
}

variable "startpage_dev_cloudfront_dist_arn" {
  description = "ARN value of the development startpage cloudfront distribution"
  type        = string
}
