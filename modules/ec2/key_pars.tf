resource "aws_key_pair" "ci-devops" {
  key_name = "ci-devops"
  public_key = "${file("~/.ssh/ci-devops.pub")}"
}
