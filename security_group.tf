resource "aws_security_group" "allow_ssh" {
  name        = "${var.tag_common_sg}"
  description = "Allow ssh traffic"
  vpc_id = "${data.aws_vpc.production.id}"

  ingress {
    from_port   = "${var.ssh_port}" #
    to_port     = "${var.ssh_port}"
    protocol =   "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags {
    Name = "${var.tag_common_sg}"
  }
}

resource "aws_security_group" "allow_http" {
  name        = "${var.tag_app_sg}"
  description = "Allow http traffic"
  vpc_id = "${data.aws_vpc.production.id}"

  ingress {
    from_port   = 80 #
    to_port     = 80
    protocol =   "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags {
    Name = "${var.tag_app_sg}"
  }
}
