provider "aws" {
  region = "ap-south-1"
  # region = "us-west-1"
}

resource "aws_key_pair" "shubhamtatvamasi" {
  key_name   = "shubhamtatvamasi-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

data "aws_vpc" "default" {
  default = true
} 

module "ssh_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/ssh"
  version = "~> 4.0"

  name = "ssh-security-group"
  vpc_id = data.aws_vpc.default.id
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "Spot Instance - Github Actions"

  create_spot_instance = true
  # spot_price           = "0.60"
  # spot_type            = "persistent"

  # ami                    = "ami-00a0488e9d5582804" # Linux kernal 5.4.0-1009-aws - Ubuntu 20.04 LTS - us-west-1
  ami           = "ami-0491e5015eb6e7a9b" # Linux kernal 5.4.0-1009-aws - Ubuntu 20.04 LTS - ap-south-1
  instance_type = "t4g.medium"
  key_name      = aws_key_pair.shubhamtatvamasi.key_name
  monitoring             = true
  vpc_security_group_ids = [module.ssh_security_group.security_group_id]
  # subnet_id              = "subnet-eddcdzz4"

  root_block_device = [
    {
      volume_type = "gp3"
      volume_size = 50
    }
  ]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
