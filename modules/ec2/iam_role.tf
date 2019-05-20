# provider "aws" {
#   region = "eu-west-1"
#   profile = "smartmob"
# }

# resource "aws_iam_role" "nexedus" {
#   name = "nexedus"
#   assume_role_policy = "${file("iam_role_ec2_readonly.json")}"
#   tags = {
#     Name = "nexedus"
#     env = "production"
#   }
# }
