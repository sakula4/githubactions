# ------------------------------------------------------------------------------
# LOCALS
# ------------------------------------------------------------------------------
locals {
  env_vars = read_terragrunt_config(find_in_parent_folders(include.root.locals.config_file))

  stack = {
    path    = local.env_vars.locals.public_dns.path
    version = coalesce(local.env_vars.locals.public_dns.version, local.env_vars.locals.stacks_version, include.root.locals.stacks.version)
  }

  source_url = "${include.root.locals.stacks.repo_url}//${local.stack.path}?ref=${local.stack.version}"

  module_tags = {
    Tenant        = "Acuity-Platform"
    ResourceGroup = "Public-DNS"
    Environment   = include.root.locals.env_long
    Region        = include.root.locals.region
  }
  tags_all = merge(local.module_tags, include.root.locals.common_tags)
}
# ------------------------------------------------------------------------------
# INPUTS
# ------------------------------------------------------------------------------
inputs = {
  aws_region         = include.root.locals.region
  parent_domain_name = include.root.locals.domain.name
  subdomain = {
    name    = local.env_vars.locals.public_dns.domain.name
    comment = local.env_vars.locals.public_dns.domain.comment
  }

  tags = local.tags_all
}
# ------------------------------------------------------------------------------
# SOURCE
# ------------------------------------------------------------------------------
terraform {
  source = "${local.source_url}"
}
# ------------------------------------------------------------------------------
# INCLUDES
# ------------------------------------------------------------------------------
include "root" {
  path   = find_in_parent_folders()
  expose = true
}
# ------------------------------------------------------------------------------
# PROVIDERS
# ------------------------------------------------------------------------------
generate "provider" {
  path              = "provider.tf"
  if_exists         = "overwrite"
  disable_signature = true

  contents = <<-EOT
    provider "aws" {
      alias = "child"
      region = "${include.root.locals.region}"
      assume_role {
        role_arn      = "arn:aws:iam::${local.env_vars.locals.aws.account_id}:role/${include.root.locals.oidc_exec_role_name}"
        session_name  = "child-dns-public"
      }
    }
    
    provider "aws" {
      alias = "parent"
      region = "${include.root.locals.region}"
      assume_role {
        role_arn      = "arn:aws:iam::${include.root.locals.aws_account_map.prod}:role/${include.root.locals.oidc_exec_role_name}" 
        session_name  = "root-dns-public"
      }
    }
  EOT
}
