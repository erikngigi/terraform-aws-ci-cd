terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "ericngigi"
}

# Configure the Cloudflare provider
provider "cloudflare" {}

# Terraform statefile bucket storage 
terraform {
  backend "s3" {
    bucket       = "ericngigi-terraform-states"
    key          = "multi-static-sites/dev/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
    profile      = "ericngigi"
  }
}
