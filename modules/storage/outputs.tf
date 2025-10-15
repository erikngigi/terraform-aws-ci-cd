output "hugo_bucket_arn" {
  description = "ARN value of the Hugo S3 bucket"
  value       = aws_s3_bucket.hugo_site.arn
}

output "startpage_bucket_arn" {
  description = "ARN value of the Startpage S3 bucket"
  value       = aws_s3_bucket.startpage_site.arn
}

output "hugo_bucket_id" {
  description = "ID value of the Hugo S3 bucket"
  value       = aws_s3_bucket.hugo_site.id
}

output "startpage_bucket_id" {
  description = "ID value of the Startpage S3 bucket"
  value       = aws_s3_bucket.startpage_site.id
}

output "hugo_bucket_domain_name" {
  description = "Bucket domain name of the Hugo S3 bucket"
  value       = aws_s3_bucket.hugo_site.bucket_regional_domain_name
}

output "startpage_bucket_domain_name" {
  description = "Bucket domain name of the Startpage S3 bucket"
  value       = aws_s3_bucket.startpage_site.bucket_domain_name
}
