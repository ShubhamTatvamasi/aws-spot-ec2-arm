provider "aws" {
  region = local.region
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "Docker AGW ARM - 5.4 Kernal"

  create_spot_instance = true
  spot_type            = "one-time"

  ami           = local.ami
  instance_type = local.instance_type
  key_name      = aws_key_pair.shubhamtatvamasi.key_name
  subnet_id     = local.subnet_id

  vpc_security_group_ids = [
    module.ssh_sg.security_group_id,
    module.local_vpc_sg.security_group_id
  ]

  root_block_device = [
    {
      volume_type = "gp3"
      volume_size = local.volume_size
    }
  ]

  tags = local.tags
}
