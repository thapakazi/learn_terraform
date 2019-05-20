output "public_ip" {
  value = "${aws_instance.app.public_ip}"
}

output "security_groups"{
  value = "${aws_security_group.allow_http.id}"
}
