terraform apply -var-file=uat.tfvars

terraform plan -var-file=uat.tfvars

terraform plan -var="access_key=your-access-key" -var="secret_key=your-secret-key"


