variable "app_iter" {
  type = "string"
}

variable "service" {
  type = "string"
}

variable "vpc_name" {
  type = "string"
}

variable "asg_size" {
  type = "string"
}

variable "vpc_security_group_ids" {
  type = "list"
}

variable "instance_type" {
  type = "string"
  default = "m5.large"
}

variable "associate_public_ip" {
  type = "string"
  default = "false"
}

