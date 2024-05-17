terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  backend "s3" {
    bucket = "yevhenii-terraform-mybucket-456"
    key    = "terraform-key"
    region = "us-east-1"
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = terraform.workspace == "default" ? "us-east-1" : "us-west-2"
}

resource "aws_instance" "example_server" {
  ami           = terraform.workspace == "default" ? "ami-04cb4ca688797756f" : "ami-0ccea833bf267252a"
  instance_type = "t2.micro"

  tags = {
    Name = "personal-instance"
  }
}