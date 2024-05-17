terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.7.0"
    }
  }
}

locals {
  ec2_instances_by_tag_name = { for instance in var.ec2_instances : instance.tag_name => {
    instance_type = instance.instance_type
    tag_name      = instance.tag_name
    ami_name      = instance.ami_name

    instance_description = instance.instance_description
    author = instance.author
  } }
}

//security.tf
resource "aws_security_group" "ingress-all-test" {
  name = "allow-all-sg"
  vpc_id = "vpc-0fe69412caf5f93c0"
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
  // Terraform removes the default rule
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "server" {
  for_each = local.ec2_instances_by_tag_name

  ami           = each.value.ami_name
  instance_type = each.value.instance_type

  key_name = "zfs-test-key-pair"
  vpc_security_group_ids = [aws_security_group.ingress-all-test.id]

  tags = {
    Name = each.value.tag_name
    InstanceDescription = each.value.instance_description
    Author = each.value.author
  }

  user_data = filebase64("/Users/yevheniishcherbina/go/src/github.com/evgeniy-scherbina/sandbox/terraform/lesson6/script.sh")
}
