variable "ec2_instances" {
  type = list(object({
    instance_type = string
    tag_name      = string
    ami_name      = string

    instance_description = optional(string)
    author = optional(string, "Yevhenii")
  }))
}