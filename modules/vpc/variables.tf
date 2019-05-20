#### vpc variables
variable "igw_tags" {
  type = "map"
  default = {
    Name = "production-vpc"
    env  = "production"
  }
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
  }
}
variable "private_rtb_tags" {
  type = "map"
  default = {
    Name = "prvate_rtb"
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

variable "vpc_id" {}


### provider variables
variable "aws_region" {
  default = "us-west-1"
}
variable "aws_profile" {
  default = "smartmob"
}


variable subnet_a_public {
  default = {
    cidr = "10.0.32.0/20"
    az  = "us-west-1a"
    tagName = "subnet_a_public"
  }
}

variable subnet_a_private {
  default = {
    cidr = "10.0.0.0/19"
    az  = "us-west-1a"
    tagName = "subnet_a_private"
  }
}

variable subnet_c_public {
  default = {
    cidr = "10.0.96.0/20"
    az  = "us-west-1c"
    tagName = "subnet_c_public"
  }
}

variable subnet_c_private {
  default = {
    cidr = "10.0.64.0/19"
    az  = "us-west-1c"
    tagName = "subnet_c_private"
  }
}
