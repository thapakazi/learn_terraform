output "igw_id" {
  value       = "${aws_internet_gateway.default.id}"
  description = "The ID of the Internet Gateway"
}

output "vpc_id" {
  value       = "${aws_vpc.default.id}"
  description = "The ID of the VPC"
}

output "vpc_cidr_block" {
  value       = "${aws_vpc.default.cidr_block}"
  description = "The CIDR block of the VPC"
}

output "subnet_id_a_private" {
  value = "${aws_subnet.PrivateA.id}"
}

output "subnet_id_a_public" {
  value = "${aws_subnet.PublicA.id}"
}

output "subnet_id_c_private" {
  value = "${aws_subnet.PrivateC.id}"
}

output "subnet_id_c_public" {
  value = "${aws_subnet.PublicC.id}"
}
