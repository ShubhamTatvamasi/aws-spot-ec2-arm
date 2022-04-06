locals {
  region = "us-west-1"

  subnet_id     = "subnet-2674e740"
  instance_type = "t4g.medium"
  volume_size   = 50

  ami = "ami-00a0488e9d5582804" # Linux kernal 5.4.0-1017-aws - Ubuntu 20.04 LTS - us-west-1
  # ami = "ami-0491e5015eb6e7a9b" # Linux kernal 5.4.0-1009-aws - Ubuntu 20.04 LTS - ap-south-1

  tags = {
    Name        = "Docker AGW ARM - 5.4 Kernal"
    Environment = "dev"
  }
}
