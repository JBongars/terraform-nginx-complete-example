# Terraform Nginx Complete Example

This example shows how to deploy a nginx server in a private subnet using terraform.

## How to Run

1. Clone the repository
2. Run the Docker development container
   - dev.ps1
   - dev.sh
3. Run the setup
   - ./scripts/generate_key.sh
   - ./scripts/generate_ssl.sh
4. Make sure you have a valid AWS profile configured with a default VPC
5. Run the terraform Setup
   - ./scripts/init_terraform.sh
6. Generate AMI images using Packer
   - ./scripts/build_ami.sh test
7. Deploy the infrastructure
   - ./scripts/tf test apply

Done!

## Improvements

- Use vault or secrets manager to store the private key
- Use a bastion host/ network load balancer to access nginx server in a private subnet
- restrict network ACL access
- Use a load balancer to distribute traffic to multiple nginx servers
- Use a CDN to cache static content
- Use a WAF to protect against malicious traffic
- Configure DNS records
