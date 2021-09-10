terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.57.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=2.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = ">=1.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }

    http = {
      source  = "hashicorp/http"
      version = "2.1.0"
    }

  }


  backend "s3" {
    bucket = "tz-tfstate-on-s3"
    key    = "tz-tfstate/"
    region = "eu-central-1"
  }

  required_version = ">=1.0.6"
}


provider "aws" {
  region = var.region_name
}

data "aws_caller_identity" "current" {}