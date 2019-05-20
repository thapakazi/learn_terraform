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
