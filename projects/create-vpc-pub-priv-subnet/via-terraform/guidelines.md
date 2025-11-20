# Terraform: modular layout

terraform/
├─ modules/
│  ├─ vpc/
│  │  ├─ main.tf
│  │  ├─ variables.tf
│  │  └─ outputs.tf
│  ├─ igw/
│  ├─ subnets/
│  ├─ nat/
│  └─ route_tables/
├─ env/
│  └─ main.tf   # root that wires modules
├─ providers.tf
└─ variables.tf  # root-level variable overrides (optional)

## Usage

cd via-terraform/env
terraform init
terraform plan -out plan.tf
terraform apply plan.tf

## Cost & cleanup reminders
 Run `terraform destroy`

