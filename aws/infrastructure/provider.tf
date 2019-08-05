terraform {
  backend "s3" {
    bucket = "tf-state-sandbox-nerdery"
    key = "terraform-infrastructure/state"
    region = "us-east-1"
  }
}

provider "aws" {
  version = "~> 2.0"
  region = var.region
}
