module "my_vpc" {
  source = "../../modules/vpc"
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  vpc_id = "${module.my_vpc.vpc_id}"
  aws_region = "us-east-1"
  aws_profile = "nextgen"
}

module "minion" {
  source = "../../modules/ec2"
  instance_type = "t2.micro"
  ami_id = "ami-0a313d6098716f372"  #ubuntu 18.04 on us-east-1
  tag_app_name = "johnwick"
  tag_app_sg= "johnwick-production-app"
  tag_common_sg = "johnwick-production-common"
  tag_app_name = "johnwick-production-app"
  tag_app_role = "app"
  tag_app_env = "production"
  tag_project = "johnwick"

  vpc_id = "${module.my_vpc.vpc_id}"
  subnet_id = "${module.my_vpc.subnet_id_a_public}"
  aws_region = "us-east-1"
  aws_profile = "nextgen"
  # instance_iam_role = "I am skipping this for now"
  # ssh_port= 22
}
