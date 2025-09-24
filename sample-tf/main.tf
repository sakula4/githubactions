terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
  required_version = ">= 1.0"
}

variable "aws_access_key_id" {
  description = "AWS Access Key ID"
  type        = string
  sensitive   = true
}

variable "aws_secret_access_key" {
  description = "AWS Secret Access Key"
  type        = string
  sensitive   = true
}

provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}

resource "aws_s3_bucket" "demo_bucket" {
  bucket = "copilot-demo-bucket-${random_pet.name.id}"
  tags = {
    Environment = "Demo"
    Owner       = "Copilot"
  }
}

resource "aws_s3_bucket_acl" "demo_bucket_acl" {
  bucket = aws_s3_bucket.demo_bucket.id
  acl    = "private"
}

resource "random_pet" "name" {
  length = 2
}

output "s3_bucket" {
  description = "The demo S3 bucket resource"
  value = aws_s3_bucket.demo_bucket
}
