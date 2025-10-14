module "cloudflare" {
  source                 = "./modules/cloudflare"
  domain_name            = var.domain_name
  subdomain_name         = var.subdomain_name
  cloudfront_url         = module.network.cloudfront_domain_name
  acm_validation_options = module.network.acm_validation_options

  providers = {
    cloudflare = cloudflare
  }
}

module "security" {
  source                      = "./modules/security"
  project_name                = var.project_name
  git_oidc_url                = var.git_oidc_url
  github_org                  = var.github_org
  github_repo                 = var.github_repo
  git_oidc_thumbprint_list    = var.git_oidc_thumbprint_list
  hugo_s3_bucket_arn          = module.storage.s3_bucket_arn
  cloudfront_distribution_arn = module.network.cloudfront_distribution_arn
}

module "storage" {
  source                      = "./modules/storage"
  project_name                = var.project_name
  cloudfront_distribution_arn = module.network.cloudfront_distribution_arn
}

module "network" {
  source                         = "./modules/network"
  s3_bucket_name                 = module.storage.s3_bucket_name
  s3_bucket_regional_domain_name = module.storage.s3_bucket_regional_domain_name
  domain_name                    = var.domain_name
  subdomain_name                 = var.subdomain_name
}
