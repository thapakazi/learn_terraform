generate_keypairs:
	mkdir -p .ssh
	ssh-keygen -f .ssh/terraform

learn_modules:
	mkdir -p modules/{vpc,ec2} stage/{dev,production}
