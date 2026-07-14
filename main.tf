module "cloudflare" {
  source                                = "./modules/cloudflare"
  hugo_name                             = var.hugo_name
  startpage_name                        = var.startpage_name
  domain_name                           = var.domain_name
  hugo_prod_domain_name                 = var.hugo_prod_domain_name
  hugo_dev_domain_name                  = var.hugo_dev_domain_name
  startpage_prod_domain_name            = var.startpage_prod_domain_name
  startpage_dev_domain_name             = var.startpage_dev_domain_name
  hugo_prod_cloudfront_domain_name      = module.network.hugo_prod_cloudfront_domain_name
  hugo_dev_cloudfront_domain_name       = module.network.hugo_dev_cloudfront_domain_name
  startpage_prod_cloudfront_domain_name = module.network.startpage_prod_cloudfront_domain_name
  startpage_dev_cloudfront_domain_name  = module.network.startpage_dev_cloudfront_domain_name
  hugo_prod_acm_validation_options      = module.network.hugo_prod_acm_validation_options
  hugo_dev_acm_validation_options       = module.network.hugo_dev_acm_validation_options
  startpage_prod_acm_validation_options = module.network.startpage_prod_acm_validation_options
  startpage_dev_acm_validation_options  = module.network.startpage_dev_acm_validation_options

  providers = {
    cloudflare = cloudflare
  }
}

module "security" {
  source                             = "./modules/security"
  hugo_name                          = var.hugo_name
  startpage_name                     = var.startpage_name
  github_oidc_url                    = var.github_oidc_url
  github_org                         = var.github_org
  github_hugo_repo                   = var.github_hugo_repo
  github_startpage_repo              = var.github_startpage_repo
  hugo_prod_bucket_arn               = module.storage.hugo_prod_bucket_arn
  hugo_dev_bucket_arn                = module.storage.hugo_dev_bucket_arn
  startpage_prod_bucket_arn          = module.storage.startpage_prod_bucket_arn
  startpage_dev_bucket_arn           = module.storage.startpage_dev_bucket_arn
  hugo_prod_cloudfront_dist_arn      = module.network.hugo_prod_cloudfront_dist_arn
  hugo_dev_cloudfront_dist_arn       = module.network.hugo_dev_cloudfront_dist_arn
  startpage_prod_cloudfront_dist_arn = module.network.startpage_prod_cloudfront_dist_arn
  startpage_dev_cloudfront_dist_arn  = module.network.startpage_dev_cloudfront_dist_arn
}

module "storage" {
  source                             = "./modules/storage"
  hugo_name                          = var.hugo_name
  startpage_name                     = var.startpage_name
  hugo_prod_cloudfront_dist_arn      = module.network.hugo_prod_cloudfront_dist_arn
  hugo_dev_cloudfront_dist_arn       = module.network.hugo_dev_cloudfront_dist_arn
  startpage_prod_cloudfront_dist_arn = module.network.startpage_prod_cloudfront_dist_arn
  startpage_dev_cloudfront_dist_arn  = module.network.startpage_dev_cloudfront_dist_arn
}

module "network" {
  source                            = "./modules/network"
  hugo_name                         = var.hugo_name
  startpage_name                    = var.startpage_name
  hugo_bucket_prod_id               = module.storage.hugo_prod_bucket_id
  hugo_bucket_dev_id                = module.storage.hugo_dev_bucket_id
  startpage_bucket_prod_id          = module.storage.startpage_prod_bucket_id
  startpage_bucket_dev_id           = module.storage.startpage_dev_bucket_id
  hugo_bucket_prod_domain_name      = module.storage.hugo_bucket_prod_domain_name
  hugo_bucket_dev_domain_name       = module.storage.hugo_bucket_dev_domain_name
  startpage_bucket_prod_domain_name = module.storage.startpage_bucket_prod_domain_name
  startpage_bucket_dev_domain_name  = module.storage.startpage_bucket_dev_domain_name
  domain_name                       = var.domain_name
  hugo_prod_domain_name             = var.hugo_prod_domain_name
  hugo_dev_domain_name              = var.hugo_dev_domain_name
  startpage_prod_domain_name        = var.startpage_prod_domain_name
  startpage_dev_domain_name         = var.startpage_dev_domain_name
}
