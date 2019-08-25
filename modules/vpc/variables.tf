# File:
#  - modules/vpc/variables.tf

variable "cidr_vpc1" {
  default = "172.16.0.0/16"
}

variable "cidr_vpc2" {
  default = "172.17.0.0/16"
}

variable "cidr_vpc2_secondary" {
  default = "172.30.0.0/20"
}

variable "availability_zones" {
  default = [
    "eu-central-1a",
    "eu-central-1b",
    "eu-central-1c"
  ]
  type = "list"
}

variable "task_tags" {
  type = "map"
  default = {
    Task: "DevSecOps-AWS",
    Tool: "Terraform"
  }
}

variable "ami_amazon_linux_2" {
  default = "ami-0cc293023f983ed53"
  description = "AMI Amazon Linux 2"
}

variable "key_pair" {
  default = "id_rsa_a.nadyozhny_eu-central-1"
  description = "SSH Public Key"
}

variable "iam_role_bastion" {
  default = "Bastion-Host-Role"
  description = "Custom created IAM Role for Bastion Host"
}
