terraform {
  backend "s3" {
    bucket         = "github-mygainwell-acuity-tf-state"
    region         = "us-east-1"
    key            = "gw360/{ENV1}/infra/{ENV2}/api/us-east-1/terraform.tfstate"
    dynamodb_table = "github-mygainwell-acuity-tf-state-lockdb"
  }
}
