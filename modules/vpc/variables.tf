#### vpc variables
variable "igw_tags" {
  type = "map"
  default = {
    Name = "production-vpc"
    env  = "production"
  }
}

locals {
  env = "production"
}

variable "vpc_tags" {
  type = "map"
  default = {
    Name = "production-vpc"
    env  = "production"
  }
}
variable "public_rtb_tags" {
  type = "map"
  default = {
    Name = "public_rtb"
    env  = "production"
  }  
}

variable "enable_dns_hostnames" {
  default = "True"
}

variable "enable_dns_support" {
  default = "True"
}

variable "instance_tenancy" {
  default = "default"
}
variable "cidr_block" {
  description = "CIDR block range"
  default = "10.0.0.0/16"
}

### provider variables
variable "aws_region" {
  default = "us-west-1"
}
variable "aws_profile" {
  default = "smartmob"
}
