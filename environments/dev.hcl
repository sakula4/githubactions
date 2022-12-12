locals {
  stacks_version = "0.40.0"

  awslogs_bucket = "gwt-testorg-account-id-us1-awslogs"

  aws = {
    account_id   = "798001646746"
    canonical_id = "f3cc392736dff1e97be6adff0fbd30fbf53b3e17d78700194624c899238ec5d2"
    alias        = "dxc-aws-ppa-dxchhs-edwproducts-dev-us"
  }

  okta = {
    org_name     = "dev-24236525"
    base_url     = "okta.com"
    audience     = "test"
    issuer_uri   = "random"
    metadata_uri = "another-random"
  }

  account_baseline = {
    version           = ""
    path              = "baseline"
    enabled           = true
    create_budget     = true
    max_monthly_spend = 1000
  }

  ssm_documents = {
    version = ""
    path    = "stacks/ssm-documents"
    enabled = true
  }

  viz_network = {
    version          = ""
    path             = "network"
    enabled          = true
    cidr_block       = "192.168.4.0/24"
    num_nat_gws      = 1
    cwlogs_retention = 90
    traffic_type     = "REJECT"
  }

  public_dns = {
    version = ""
    path    = "dns"
    enabled = true
    domain = {
      name    = "dev"
      comment = "Development Environment Subdomain"
    }
  }

  alb = {
    version = ""
    path    = "stacks/alb"
    enabled = true
  }

  dbx_integration = {
    version = ""
    path    = "apps/databricks/credentials"
    enabled = true
  }

  reference_data = {
    version = ""
    path    = "apps/databricks/reference-data"
    enabled = true

  }

  datadog = {
    version = ""
    path    = "stacks/monitoring/datadog"
    enabled = true
  }

  abc_network = {
    version          = ""
    path             = "network"
    enabled          = true
    cidr_block       = "192.168.4.0/24"
    num_nat_gws      = 0
    cwlogs_retention = 90
    traffic_type     = "REJECT"
  }

  abc_database = {
    version = ""
    path    = "rds"
    enabled = true
    engine = {
      name    = "postgres"
      version = "13.7"
    }
    port                    = 5232
    db_name                 = "abc"
    admin_username          = "testadmin"
    instance_type           = "db.t3.micro"
    allocated_storage       = 100
    max_allocated_storage   = 150
    num_read_replicas       = 0
    backup_retention_period = 5
  }

  dbx_queues = {
    version = ""
    path    = "apps/databricks/abc"
    enabled = true
  }

  tableau_server = {
    version        = ""
    path           = "apps/tableau"
    enabled        = true
    server_version = "2022.1.2"

  }

  oz_network = {
    version = ""
    path    = "network"
    enabled = true
    stage   = "dbws"

    cidr_block                             = "192.168.8.0/21"
    num_nat_gws                            = 1
    num_azs                                = 6
    create_public_subnets                  = true
    create_private_subnets                 = true
    create_isolated_subnets                = true
    allow_isolated_subnets_internet_access = true
    create_vpc_endpoints                   = true
    public_subnets = {
      AZ-0 = cidrsubnet("192.168.8.0/21", 5, 0)
      AZ-1 = cidrsubnet("192.168.8.0/21", 5, 1)
      AZ-2 = cidrsubnet("192.168.8.0/21", 5, 2)
      AZ-3 = cidrsubnet("192.168.8.0/21", 5, 3)
      AZ-4 = cidrsubnet("192.168.8.0/21", 5, 4)
      AZ-5 = cidrsubnet("192.168.8.0/21", 5, 5)
    }
    private_subnets = {
      AZ-0 = cidrsubnet("192.168.8.0/21", 5, 6)
      AZ-1 = cidrsubnet("192.168.8.0/21", 5, 7)
      AZ-2 = cidrsubnet("192.168.8.0/21", 5, 8)
      AZ-3 = cidrsubnet("192.168.8.0/21", 5, 9)
      AZ-4 = cidrsubnet("192.168.8.0/21", 5, 10)
      AZ-5 = cidrsubnet("192.168.8.0/21", 5, 11)
    }
    isolated_subnets = {
      AZ-0 = cidrsubnet("192.168.8.0/21", 5, 12)
      AZ-1 = cidrsubnet("192.168.8.0/21", 5, 13)
      AZ-2 = cidrsubnet("192.168.8.0/21", 5, 14)
      AZ-3 = cidrsubnet("192.168.8.0/21", 5, 15)
      AZ-4 = cidrsubnet("192.168.8.0/21", 5, 16)
      AZ-5 = cidrsubnet("192.168.8.0/21", 5, 17)
    }
    cwlogs_retention = 90
    traffic_type     = "REJECT"
  }

  cluster_policies = {
    version = ""
    path    = "apps/databricks/cluster"
    enabled = true
  }

  workspace = {
    version = ""
    path    = "apps/databricks/workspace"
    enabled = true

    dbws_suffix = "ozd"
  }

  metastore = {
    version = ""
    path    = "apps/databricks/uc-metastore"
    enabled = true
  }

  datalake = {
    version          = ""
    path             = "apps/databricks/datalake"
    enabled          = true
    object_lock_mode = "COMPLIANCE"
    object_lock_days = 1
  }

  unity_catalog = {
    version = ""
    path    = "apps/databricks/unity-catalog"
    enabled = true
  }

  service_principals = {
    version = ""
    path    = "apps/databricks/service-principals"
    enabled = false
  }
}
