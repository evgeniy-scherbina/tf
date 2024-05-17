variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "tag_name" {
  type    = string
  default = "personal-instance"
}

variable "ami_name" {
  type    = string
  default = "ami-04cb4ca688797756f"
}