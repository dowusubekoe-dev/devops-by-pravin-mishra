# Deployment notes (CloudFormation)

- Deploy with `aws cloudformation deploy --template-file vpc-2az-nat.yaml --stack-name demo-vpc --capabilities CAPABILITY_NAMED_IAM` (no IAM changes here, but keep capability safe).

- CloudFormation will create NAT Gateways which take a short time to reach available state. Wait for stack create to finish before launching instances in private subnets.

- Required IAM: ability to create ec2:* for VPC/subnet/igw/eip/natgw/routetables.

## Cost & cleanup reminders

- NAT Gateways and Elastic IPs are billable while allocated. Destroy stacks/resources when finished.

- CloudFormation: `aws cloudformation delete-stack --stack-name demo-vpc`