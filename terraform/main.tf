terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.10.0"
    }
  }
  
  required_version="0.15.4"
}

#configure the AWS provider
provider "aws" {
  region                  = "us-east-1"
  profile                 = "default"
}


