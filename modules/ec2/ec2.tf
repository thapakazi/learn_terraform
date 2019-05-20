provider "aws" {
  region  = "${var.aws_region}"
  profile = "${var.aws_profile}"
}

data "aws_vpc" "production" {
  id = "${var.vpc_id}"
}

resource "aws_instance" "app" {
  ami                  = "${var.ami_id}"
  instance_type        = "${var.instance_type}"
  key_name             = "${aws_key_pair.terraform.key_name}"
  iam_instance_profile = "${var.instance_iam_role}"
  user_data            = "${file("../../user-data/userdata.sh")}"
  root_block_device{
    volume_size        = 16
    volume_type        = "gp2"
  }
  
  tags {
    Name    = "${var.tag_app_name}"
    role    = "${var.tag_app_role}"
    env     = "${var.tag_app_env}"
    project = "${var.tag_project}"
  }
  subnet_id = "${var.subnet_id}"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}", "${aws_security_group.allow_http.id}"]
}
