terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.7.0"
    }
  }
}

resource "aws_instance" "server" {
  ami           = var.ami_name
  instance_type = var.instance_type

  tags = {
    Name = var.tag_name
  }
}