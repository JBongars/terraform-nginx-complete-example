# Terraform Nginx Complete Example

This example shows how to deploy a nginx server in a private subnet using terraform.

## Improvements

- Use vault or secrets manager to store the private key
- Use a bastion host/ network load balancer to access nginx server in a private subnet
- restrict network ACL access
- Use a load balancer to distribute traffic to multiple nginx servers
- Use a CDN to cache static content
- Use a WAF to protect against malicious traffic
- Configure DNS records
