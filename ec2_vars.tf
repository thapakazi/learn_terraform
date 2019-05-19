variable "tag_common_sg" {
  description = "Security Group common for all"
}
variable "tag_app_sg" {
  description = "Security group Name for app"

}
variable "tag_project" {}
variable "tag_app_name" {}
variable "tag_app_env" {}
variable "tag_app_role" {}

variable "vpc_id" {
  description = "The ID of the VPC that the instance security group belongs to"
}

variable "subnet_private" {
  description = "VPC Subnet ID the instance is launched in"
}

variable "instance_iam_role"{
  description = "IAM role to attach to instance"
}

variable "ami_id"{
  default = "ami-08d658f84a6d84a80"
  description = "Ubuntu 18.04 on eu-west-1 region"
}

variable "instance_type"{
  default = "t3.medium"
}

variable aws_region {}
variable aws_profile {}
variable ssh_port {}
