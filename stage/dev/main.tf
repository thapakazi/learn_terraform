module "my_vpc" {
  source = "../../modules/vpc"
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  vpc_id = "${module.my_vpc.vpc_id}"
  aws_region = "us-east-1"
}

# module "minion" {
#   source = "../../modules/ec2"
#   instance_type = "t2.micro"
#   subnet_id = "${module.my_vpc.subnet_public_a_cidr}"

#   app_name = "johnwick"
#   tag_app_sg= "johnwick-production-app"
#   tag_common_sg = "johnwick-production-common"
#   tag_app_name = "johnwick-production-app"
#   tag_app_role = "app"
#   tag_app_env = "production"
#   tag_project = "johnwick"

#   vpc_id = "vpc-0a0ca8fd7b360c5ec"
#   subnet_private = "subnet-0a400b0af8b0e0851"
#   aws_region = "eu-west-1"
#   aws_profile = "smartmob"
#   instance_iam_role = "johnwick"
#   ssh_port=3333
# }
