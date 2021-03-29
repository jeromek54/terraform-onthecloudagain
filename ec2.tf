terraform {
  required_version = "~> 0.14"
  required_providers {
    aws = {
      source    = "hashicorp/aws"
      version   = "~> 3.20"
    }
  }
}

provider "aws" {
  alias         = "aws01"
  region        = "eu-west-3"
}
provider "aws" {
  alias         = "aws02"
  region        = "eu-west-3"
}

resource "aws_instance" "terra_ec2" {
  provider = aws.aws02

  ami                           = "ami-0ba7c4110ca9bfe0b"
  instance_type                 = "t2.micro"
  key_name                      = var.my-key
  tags                          = {Test="true"}

  ebs_block_device {
    delete_on_termination       = true
    device_name                 = "/dev/sdb"
    encrypted                   = true
    volume_size                 = 3
  }
}

output "instance" {
  value = aws_instance.terra_ec2.id
  description = "Sensitive thing!"
  sensitive = true
}
