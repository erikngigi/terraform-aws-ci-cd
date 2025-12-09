module "cloudflare" {
  source                           = "./modules/cloudflare"
  hugo_name                        = var.hugo_name
  startpage_name                   = var.startpage_name
  domain_name                      = var.domain_name
  hugo_subdomain_name              = var.hugo_subdomain_name
  hugo_www_subdomain_name          = var.hugo_www_subdomain_name
  startpage_subdomain_name         = var.startpage_subdomain_name
  hugo_cloudfront_domain_name      = module.network.hugo_cloudfront_domain_name
  startpage_cloudfront_domain_name = module.network.startpage_cloudfront_domain_name
  hugo_acm_validation_options      = module.network.hugo_acm_validation_options
  startpage_acm_validation_options = module.network.startpage_acm_validation_options

  providers = {
    cloudflare = cloudflare
  }
}

module "security" {
  source                        = "./modules/security"
  hugo_name                     = var.hugo_name
  startpage_name                = var.startpage_name
  github_oidc_url               = var.github_oidc_url
  github_org                    = var.github_org
  github_hugo_repo              = var.github_hugo_repo
  github_startpage_repo         = var.github_startpage_repo
  hugo_bucket_arn               = module.storage.hugo_bucket_arn
  startpage_bucket_arn          = module.storage.startpage_bucket_arn
  hugo_cloudfront_dist_arn      = module.network.hugo_cloudfront_dist_arn
  startpage_cloudfront_dist_arn = module.network.startpage_cloudfront_dist_arn
}

module "storage" {
  source                        = "./modules/storage"
  hugo_name                     = var.hugo_name
  startpage_name                = var.startpage_name
  hugo_cloudfront_dist_arn      = module.network.hugo_cloudfront_dist_arn
  startpage_cloudfront_dist_arn = module.network.startpage_cloudfront_dist_arn
}

module "network" {
  source                       = "./modules/network"
  hugo_name                    = var.hugo_name
  startpage_name               = var.startpage_name
  hugo_bucket_id               = module.storage.hugo_bucket_id
  startpage_bucket_id          = module.storage.startpage_bucket_id
  hugo_bucket_domain_name      = module.storage.hugo_bucket_domain_name
  startpage_bucket_domain_name = module.storage.startpage_bucket_domain_name
  domain_name                  = var.domain_name
  hugo_subdomain_name          = var.hugo_subdomain_name
  hugo_www_subdomain_name      = var.hugo_www_subdomain_name
  startpage_subdomain_name     = var.startpage_subdomain_name
}
