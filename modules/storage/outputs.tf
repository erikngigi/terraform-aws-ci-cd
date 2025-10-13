output "s3_bucket_arn" {
  description = "Resource output for the ARN value of the hugo s3 bucket"
  value       = aws_s3_bucket.hugo_site.arn
}

output "s3_bucket_name" {
  description = "Name of the s3 bucket"
  value       = aws_s3_bucket.hugo_site.id
}

output "s3_bucket_regional_domain_name" {
  description = "Domain name of the s3 bucket"
  value       = aws_s3_bucket.hugo_site.bucket_regional_domain_name
}
