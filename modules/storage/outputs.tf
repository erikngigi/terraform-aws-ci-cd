output "hugo_prod_bucket_arn" {
  description = "ARN value of the Hugo production S3 bucket"
  value       = aws_s3_bucket.hugo_prod_site.arn
}

output "hugo_dev_bucket_arn" {
  description = "ARN value of the Hugo development S3 bucket"
  value       = aws_s3_bucket.hugo_dev_site.arn
}

output "startpage_prod_bucket_arn" {
  description = "ARN value of the Startpage production S3 bucket"
  value       = aws_s3_bucket.startpage_prod_site.arn
}

output "startpage_dev_bucket_arn" {
  description = "ARN value of the Startpage development S3 bucket"
  value       = aws_s3_bucket.startpage_dev_site.arn
}

output "hugo_prod_bucket_id" {
  description = "ID value of the Hugo production S3 bucket"
  value       = aws_s3_bucket.hugo_prod_site.id
}

output "hugo_dev_bucket_id" {
  description = "ID value of the Hugo development S3 bucket"
  value       = aws_s3_bucket.hugo_dev_site.id
}

output "startpage_prod_bucket_id" {
  description = "ID value of the Startpage production S3 bucket"
  value       = aws_s3_bucket.startpage_prod_site.id
}

output "startpage_dev_bucket_id" {
  description = "ID value of the Startpage development S3 bucket"
  value       = aws_s3_bucket.startpage_dev_site.id
}

output "hugo_bucket_prod_domain_name" {
  description = "Bucket domain name of the Hugo production S3 bucket"
  value       = aws_s3_bucket.hugo_prod_site.bucket_domain_name
}

output "hugo_bucket_dev_domain_name" {
  description = "Bucket domain name of the Hugo development S3 bucket"
  value       = aws_s3_bucket.hugo_dev_site.bucket_domain_name
}

output "startpage_bucket_prod_domain_name" {
  description = "Bucket domain name of the Startpage production S3 bucket"
  value       = aws_s3_bucket.startpage_prod_site.bucket_domain_name
}

output "startpage_bucket_dev_domain_name" {
  description = "Bucket domain name of the Startpage development S3 bucket"
  value       = aws_s3_bucket.startpage_dev_site.bucket_domain_name
}
