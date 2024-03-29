terraform {
  backend "s3" {
    bucket         = "github-mygainwell-acuity-tf-state"
    region         = "us-east-1"
    key            = "gw360/{ENV1}/infra/{ENV2}/api/us-east-1/terraform.tfstate"
    dynamodb_table = "github-mygainwell-acuity-tf-state-lockdb"
  }
}



data "terraform_remote_state" "state" {
  backend = "s3"
  config = {
    bucket = var.state_bucket_name
    key    = "gw360/ephermical/infra/ephem/api/us-east-1/terraform.tfstate"
    region = var.aws_region
  }
}


output "test" {
  value = data.terraform_remote_state.state.outputs
}
