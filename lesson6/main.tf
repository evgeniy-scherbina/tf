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

module "servers" {
  source = "./ec2"

  ec2_instances = [
    {
      instance_type        = "t2.micro"
      tag_name             = "instance-5"
      ami_name             = "ami-04cb4ca688797756f"
    },
    {
      instance_type        = "t2.micro"
      tag_name             = "instance-6"
      ami_name             = "ami-04cb4ca688797756f"
      instance_description = "6th instance for test purposes"
      author               = "Alona"
    },
  ]
}
