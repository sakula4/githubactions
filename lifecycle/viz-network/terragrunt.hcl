# ------------------------------------------------------------------------------
# LOCALS
# ------------------------------------------------------------------------------
locals {
  env_vars = read_terragrunt_config(find_in_parent_folders(include.root.locals.config_file))

  stack = {
    path    = local.env_vars.locals.viz_network.path
    version = coalesce(local.env_vars.locals.viz_network.version, local.env_vars.locals.stacks_version, include.root.locals.stacks.version)
  }

  source_url = "${include.root.locals.stacks.repo_url}//${local.stack.path}?ref=${local.stack.version}"

  module_tags = {
    Tenant        = "testity-Platform"
    ResourceGroup = "Visualization-Network"
    Environment   = include.root.locals.env_long
    Region        = include.root.locals.region
  }
  tags_all = merge(local.module_tags, include.root.locals.common_tags)
}
# ------------------------------------------------------------------------------
# INPUTS
# ------------------------------------------------------------------------------
inputs = {
  environment = include.root.locals.env
  stage       = "viz"

  aws_region       = include.root.locals.region
  num_nat_gateways = local.env_vars.locals.viz_network.num_nat_gws
  cidr_block       = local.env_vars.locals.viz_network.cidr_block

  num_availability_zones = 4
  create_public_subnets  = true
  public_subnets_cidr_blocks = {
    AZ-0 = cidrsubnet(local.env_vars.locals.viz_network.cidr_block, 3, 0)
    AZ-1 = cidrsubnet(local.env_vars.locals.viz_network.cidr_block, 3, 1)
    AZ-2 = cidrsubnet(local.env_vars.locals.viz_network.cidr_block, 3, 2)
    AZ-3 = cidrsubnet(local.env_vars.locals.viz_network.cidr_block, 3, 3)
  }
  create_private_subnets = true
  private_subnet_cidr_blocks = {
    AZ-0 = cidrsubnet(local.env_vars.locals.viz_network.cidr_block, 3, 4)
    AZ-1 = cidrsubnet(local.env_vars.locals.viz_network.cidr_block, 3, 5)
    AZ-2 = cidrsubnet(local.env_vars.locals.viz_network.cidr_block, 3, 6)
    AZ-3 = cidrsubnet(local.env_vars.locals.viz_network.cidr_block, 3, 7)
  }
  create_isolated_subnets     = false
  isolated_subnet_cidr_blocks = {}

  create_vpc_endpoints = true

  traffic_type             = local.env_vars.locals.viz_network.traffic_type
  cloudwatch_log_retention = local.env_vars.locals.viz_network.cwlogs_retention

  tags = local.tags_all
}
# ------------------------------------------------------------------------------
# SOURCE
# ------------------------------------------------------------------------------
terraform {
  source = local.source_url
}
# ------------------------------------------------------------------------------
# INCLUDES
# ------------------------------------------------------------------------------
include "root" {
  path   = find_in_parent_folders()
  expose = true
}
