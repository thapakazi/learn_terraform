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

# internet gateway
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
  tags   = "${var.igw_tags}"
}

# a route table to associate public subnets
resource "aws_route_table" "public_route_table" {
  vpc_id = "${aws_vpc.default.id}"
  tags   = "${var.public_rtb_tags}"
}

# create a route to internet
resource "aws_route" "internet_access" {
  route_table_id = "${aws_route_table.public_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"
}

####################################
# Connect private subnet to internet
# Elastic IP
resource "aws_eip" "default" {
  vpc      = true
  # depends_on = ["aws_internet_gateway.default"]
}

#Nat Gateway, so subnet minions can talk to internet outside
# putting it on publicA subnet
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = "${aws_eip.default.id}"
  subnet_id = "${aws_subnet.PublicA.id}"
  depends_on = ["aws_eip.default", "aws_subnet.PublicA"]
}

# create a route table entry and route traffic
resource "aws_route_table" "private_route_table" {
  vpc_id = "${aws_vpc.default.id}"
  tags   = "${var.private_rtb_tags}"
}

resource "aws_route" "private_route" {
  route_table_id  = "${aws_route_table.private_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = "${aws_nat_gateway.nat_gw.id}"
}

####################################
### public subnets
####################################
resource "aws_subnet" "PublicA" {
  vpc_id= "${var.vpc_id}"
  cidr_block = "${var.subnet_a_public["cidr"]}"
  availability_zone  = "${var.subnet_a_public["az"]}"
  tags {
    Name = "${var.subnet_a_public["tagName"]}"
  }
  map_public_ip_on_launch = true
}

# associate subnet to public route table
resource "aws_route_table_association" "subnet_a_public_association" {
    subnet_id = "${aws_subnet.PublicA.id}"
    route_table_id = "${aws_route_table.public_route_table.id}"
}

resource "aws_subnet" "PublicC" {
  vpc_id= "${var.vpc_id}"
  cidr_block = "${var.subnet_c_public["cidr"]}"
  availability_zone  = "${var.subnet_c_public["az"]}"
  tags {
    Name = "${var.subnet_c_public["tagName"]}"
  }
  map_public_ip_on_launch = true
}
# associate subnet to public route table
resource "aws_route_table_association" "subnet_c_public_association" {
    subnet_id = "${aws_subnet.PublicC.id}"
    route_table_id = "${aws_route_table.public_route_table.id}"
}


####################################
### private subnets
####################################
resource "aws_subnet" "PrivateA" {
  vpc_id= "${var.vpc_id}"
  cidr_block = "${var.subnet_a_private["cidr"]}"
  availability_zone  = "${var.subnet_a_private["az"]}"
  tags {
    Name = "${var.subnet_a_private["tagName"]}"
  }
}

resource "aws_route_table_association" "subnet_a_private_association" {
    subnet_id = "${aws_subnet.PrivateA.id}"
    route_table_id = "${aws_route_table.private_route_table.id}"
}

resource "aws_subnet" "PrivateC" {
  vpc_id= "${var.vpc_id}"
  cidr_block = "${var.subnet_c_private["cidr"]}"
  availability_zone  = "${var.subnet_c_private["az"]}"
  tags {
    Name = "${var.subnet_c_private["tagName"]}"
  }
}

resource "aws_route_table_association" "subnet_c_private_association" {
    subnet_id = "${aws_subnet.PrivateC.id}"
    route_table_id = "${aws_route_table.private_route_table.id}"
}
