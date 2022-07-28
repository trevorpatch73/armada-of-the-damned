# Set Terraform Cloud Environment
terraform {
  cloud {
    organization = "tpatch"

    workspaces {
      name = "armada-of-the-damned"
    }
  }
}

# Variables Inherited From Terraform Cloud
variable "aws_key_id" {
  type = string
}

variable "aws_key_value" {
  type = string
}

# Variables Edited & Pushed By The Armada Captain
variable "aws_region" {
  default = "us-east-1"
}

variable "armada_captain_ipaddressv4" {
  type    = string
  default = "0.0.0.0/0"
}

variable "boastswain_instance_type" {
  default = "t2.micro"
}

variable "swine_instance_type" {
  default = "t2.micro"
}

variable "swine_count" {
  default = "2"
}

# Static Variables Used for Lookups
variable "ami" {
  type = map(string)

  default = {
    "us-east-1" = "ami-0cff7528ff583bf9a"
    "us-east-2" = "ami-02d1e544b84bf7502"
    "us-west-1" = "ami-0d9858aa3c6322f73"
    "us-west-2" = "ami-098e42ae54c764c35"
  }
}