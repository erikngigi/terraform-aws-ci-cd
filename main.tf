module "cloudflare" {
  source      = "./modules/cloudflare"
  domain_name = var.domain_name

  providers = {
    cloudflare = cloudflare
  }
}

module "security" {
  source                   = "./modules/security"
  project_name             = var.project_name
  git_oidc_url             = var.git_oidc_url
  oidc_thumbprint          = var.oidc_thumbprint
  github_org               = var.github_org
  github_repo              = var.github_repo
  git_oidc_thumbprint_list = var.git_oidc_thumbprint_list
  hugo_s3_bucket_arn       = module.storage.s3_bucket_arn
}

module "storage" {
  source       = "./modules/storage"
  project_name = var.project_name
}
