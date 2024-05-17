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
  region = terraform.workspace == "default" ? "us-east-1" : "us-west-2"
}

#resource "aws_instance" "example_server" {
#  ami           = terraform.workspace == "default" ? "ami-04cb4ca688797756f" : "ami-0ccea833bf267252a"
#  instance_type = "t2.micro"
#
#  tags = {
#    Name = "personal-instance"
#  }
#}

resource "aws_acm_certificate" "example" {
  domain_name               = "yevhenii.xyz"
  validation_method         = "DNS"
}

data "aws_route53_zone" "example" {
  name         = "yevhenii.xyz"
  private_zone = false
}

resource "aws_route53_record" "example" {
  for_each = {
    for dvo in aws_acm_certificate.example.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.example.zone_id
}

resource "aws_acm_certificate_validation" "example" {
  certificate_arn         = aws_acm_certificate.example.arn
  validation_record_fqdns = [for record in aws_route53_record.example : record.fqdn]
}
