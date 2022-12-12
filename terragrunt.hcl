# ---------------------------------------------------------------
# GENERATE PROVIDER BLOCK
# ---------------------------------------------------------------
generate "provider" {
  path              = "provider.tf"
  if_exists         = "overwrite"
  disable_signature = true

  contents = <<-EOT
    provider "aws" {
      region = "${local.region}"

      assume_role {
        role_arn      = "${local.oidc_exec_role_arn}"
        session_name  = "platform"
      }
    }
  EOT
}
# ---------------------------------------------------------------
# GENERATE BACKEND BLOCK
# ---------------------------------------------------------------
generate "backend" {
  path              = "backend.tf"
  if_exists         = "overwrite"
  disable_signature = true

  contents = <<-EOT
    terraform {
      backend "s3" {
        bucket          = "${local.tfstate.bucket_name}"
        region          = "us-east-1"
        key             = "${local.bucket_key}"
        encrypt         = true
        dynamodb_table  = "${local.tfstate.dynamodb_table}"
      }
    }
  EOT
}
# ------------------------------------------------------------------------------
# GENERATE VERSIONS BLOCK
# ------------------------------------------------------------------------------
generate "versions" {
  path              = "versions.tf"
  if_exists         = "overwrite"
  disable_signature = true

  contents = <<-EOT
    terraform {
      required_providers {
        aws = {
          version = "< 4"
          source  = "hashicorp/aws"
        }
        
        databricks = {
          source = "databricks/databricks"
          version = "~> 1"
        }

        okta = {
          source = "okta/okta"
          version = "~> 3"
        }

        datadog = {
          source = "DataDog/datadog"
          version = "~> 3"
        }
      }
    }
  EOT
}
# ---------------------------------------------------------------
# VARIABLES
# ---------------------------------------------------------------
locals {
  env    = get_env("ENV")
  region = get_env("AWS_DEFAULT_REGION", "us-east-1")
  email  = "test@gmail.com"

  repo = {
    name     = "acuity-platform-live"
    root     = get_parent_terragrunt_dir()
    base_url = "git@github.com:sakula4/githubactions.git"
  }

  region_short = local.aws_regions_short_map[local.region]
  env_long     = local.env_map[local.env]

  config_file = format("%s/%s/%s.%s", get_parent_terragrunt_dir(), "environments", local.env, "hcl")
  bucket_key  = replace("infra/${local.region}/${path_relative_to_include()}/terraform.tfstate", "/lifecycle/", lower(local.env_map[local.env]))

  stacks = {
    repo_url = "git@github.com:mygainwell/acuity-aws-stacks.git"
    version  = "0.39.0"
  }

  namespace = "gwt"
  name      = "acuity"
  tenant    = "cmn"

  tfstate = {
    bucket_name    = "github-mygainwell-acuity-tf-state"
    dynamodb_table = "github-mygainwell-acuity-tf-state-lockdb"
  }

  oidc_exec_role_name = "gwt-acuity-infra-execution-role"
  oidc_exec_role_arn  = "arn:aws:iam::${local.aws_account_map[local.env]}:role/gwt-acuity-infra-execution-role"

  databricks = {
    account_id    = "41b9abac-ad59-4b43-b757-405183b9c40c"
    account_url   = "https://accounts.cloud.databricks.com"
    metastore_id  = "1e178aed-70fa-4621-a8d8-ff9f95b53b08"
    metastore_arn = "arn:aws:iam::350828950339:role/gwt-acuity-cmn-uc-metastore-unity-catalog-role"
  }

  domain = {
    name    = "gwtacuity.com"
    zone_id = "Z07931411EPZVKOJ5SIX"
  }

  common_tags = {
    Company     = "Gainwell Technologies"
    Project     = "Acuity Analytics Platform"
    Environment = local.env_map[local.env]
    Email       = local.email
    ManagedBy   = "Terraform"
    Tenant      = "GIA-Platform"
  }

  aws_account_map = {
    mgmt  = "350828950339"
    dev   = "918623739618"
    stage = "721214004216"
    prod  = "486777228849"
    demo  = "637842604963"
  }

  env_map = {
    mgmt  = "Management"
    dev   = "Development"
    stage = "Staging"
    prd   = "Production"
    demo  = "Demo"
  }

  aws_regions_short_map = {
    us-east-1 = "ue1"
    us-east-2 = "ue2"
    us-west-1 = "uw1"
    us-west-2 = "uw2"
  }

  tenant_map = {
    gw = "Acuity"
    oz = "Land of Oz"
    al = "Alabama"
    ak = "Alaska"
    az = "Arizona"
    ar = "Arkansas"
    ca = "California"
    co = "Colorado"
    ct = "Connecticut"
    de = "Delaware"
    dc = "District of Columbia"
    fl = "Florida"
    ga = "Georgia"
    hi = "Hawaii"
    id = "Idaho"
    il = "Illinois"
    ia = "Iowa"
    ks = "Kansas"
    ky = "Kentucky"
    la = "Louisiana"
    me = "Maine"
    md = "Maryland"
    ma = "Massachusetts"
    mi = "Michigan"
    mn = "Minnesota"
    ms = "Mississippi"
    mo = "Missouri"
    mt = "Montana"
    ne = "Nebraska"
    nv = "Nevada"
    nh = "New Hampshire"
    nj = "New Jersey"
    nm = "New Mexico"
    ny = "New York"
    nc = "North Carolina"
    nd = "North Dakota"
    oh = "Ohio"
    ok = "Oklahoma"
    or = "Oregon"
    pa = "Pennsylvania"
    pr = "Puerto Rico"
    ri = "Rhode Island"
    sc = "South Carolina"
    sd = "South Dakota"
    tn = "Tennessee"
    tx = "Texas"
    ut = "Utah"
    vt = "Vermont"
    va = "Virginia"
    vi = "Virgin Islands"
    wa = "Washington"
    wv = "West Virginia"
    wi = "Wisconsin"
    wy = "Wyoming"
  }
}
