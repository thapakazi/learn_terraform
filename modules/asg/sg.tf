resource "aws_security_group" "instance" {
  name = "${var.cluster_name}-instance"
}


resource "aws_security_group_rule" "allow_server_http_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.instance.id

  from_port   = "${var.server_port}"
  to_port     = "${var.server_port}"
  protocol    = local.tcp_protocol
  cidr_blocks = local.all_ips
}

