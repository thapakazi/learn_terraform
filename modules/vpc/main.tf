provider "aws" {
  region = "${var.aws_region}"
  profile = "${var.aws_profile}"
}

resource "aws_vpc" "default" {
  cidr_block            = "${var.cidr_block}"
  instance_tenancy      = "${var.instance_tenancy}"
  enable_dns_support    = "${var.enable_dns_support}"
  enable_dns_hostnames  = "${var.enable_dns_hostnames}"
  tags                  = "${var.vpc_tags}"
}

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
  tags   = "${var.igw_tags}"
}

resource "aws_route_table" "default" {
  vpc_id = "${aws_vpc.default.id}"
  tags   = "${var.public_rtb_tags}"
}
