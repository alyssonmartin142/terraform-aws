terraform {
  required_version = ">=1.1.7"
  required_providers {
    aws = ">=4.4.0"
  }
}

provider "aws" {
  region = var.region
}
