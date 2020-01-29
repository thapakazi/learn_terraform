plan:
	terraform plan -out /tmp/plan

apply:
	terraform apply /tmp/plan

zip:
	cd ./code && zip ../code.zip main.js

test:
	aws lambda invoke --region=us-east-1 --function-name=try_lambda /tmp/output.txt
	cat /tmp/output.txt | jq .
