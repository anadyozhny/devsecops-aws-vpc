# File:
#  - modules/vpc/main.tf
#
# Provision:
#  - VPCs:
#     - VPC1 ==> vpc1.tf
#     - VPC1 ==> vpc2.tf
#  - Internet Gateway ==> vpc1.tf, vpc2.tf
#  - Peering Connection ==> pcf.tf
#  - Public Subnets ==> public_subnets.tf
#  - Private Subnets ==> private_subnets.tf
#  - Security Groups ==> security_groups.tf
#  - Load Balancer
#  - AutoScaling Group
#  - Bastion Host EC2
#  - Route53 Record for Bastion Host
#
