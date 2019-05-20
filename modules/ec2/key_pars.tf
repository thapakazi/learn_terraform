resource "aws_key_pair" "terraform" {
  key_name = "terraform"
  public_key = "${file(".ssh/terraform.pub")}"
}
