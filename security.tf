resource "random_uuid" "ssh_key_uuid" {}

resource "aws_key_pair" "shubhamtatvamasi" {
  key_name   = "shubhamtatvamasi-key-${random_uuid.ssh_key_uuid.result}"
  public_key = file("~/.ssh/id_rsa.pub")
}

data "aws_vpc" "default" {
  default = true
}

module "local_vpc_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name   = "local-vpc-security-group"
  vpc_id = data.aws_vpc.default.id

  ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "all"
      cidr_blocks = "172.31.0.0/16"
    }
  ]
}

module "ssh_sg" {
  source  = "terraform-aws-modules/security-group/aws//modules/ssh"
  version = "~> 4.0"

  name                = "ssh-security-group"
  ingress_cidr_blocks = ["0.0.0.0/0"]
  vpc_id              = data.aws_vpc.default.id
}
