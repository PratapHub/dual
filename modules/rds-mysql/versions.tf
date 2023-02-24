terraform {
  required_version = ">= 0.14"
  required_providers {
    aws = ">= 2.0"
  }
}

provider "aws" {
  region = var.region
access_key = "AKIARYEK7HVNJ4AA2CDJ"
secret_key = "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"
}
