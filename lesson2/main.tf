terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "west"
  region = "us-west-2"
}

module "servers" {
  source = "./ec2"

#  tag_name = "testing vars"
#  ami_name = "ami-0ccea833bf267252a"

#  providers = {
#    aws = aws.west
#  }
}

module "vpc" {
  source = "./vpc"
}
