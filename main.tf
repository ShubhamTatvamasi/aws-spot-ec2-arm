provider "aws" {
  region = "ap-south-1"
}

resource "aws_key_pair" "shubhamtatvamasi" {
  key_name   = "shubhamtatvamasi-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCgZIy4AZkZPaAHaZvhC7h3kM83UqqGXywD/IofvebxIPe77fkLjETHkWnJD29+IXfhjPSTO3ODik7dys1NrIgSkSUF1bGpVcCeA7Q2OUA1cnpjnHyBcEUYG8VdCiTuWyc7JDg4K3vYp9w1bWaueCpUb9mcj9Boi3emICur259HH77Rmdx8B3TYvbLrAjfk9C58LeNy1RiiBTLqTJJmYvqxnHNy2EiO2N1xS0CtCaSVBxjH2erldJZUlHhnSUCd/f1yHpD2L1F+hSGfihBb/3mSglIf3E3mTwzvZJ3cETPXuaJ9o+Tn5qHq19nT+n7laVQm5k6eQw3jklVCvnxB6mcHAxxyf8/7bDw7+stboPBNHJrZgWKTnlkZWV+4gV+Ilv9BCQ5+m11nHRNIOmbjqyxIJb0Vi9D4sRMWZLfdHZNggGN86W65bHpJlpz46EyvIsZF5HeyyY0U76uS2H5AP439MMY66SihOAYuOkN48epiI0PEKqZm3WFXZy/w46psWzk= shubhamtatvamasi@gmail.com"
}

resource "aws_spot_instance_request" "ec2-spot-arm" {
  ami           = "ami-05eb7099cfe42bd06" # Linux kernal 5.4.0-1009-aws - Ubuntu 20.04 LTS
  instance_type = "t4g.xlarge"
  spot_type     = "one-time"
  key_name      = aws_key_pair.shubhamtatvamasi.key_name
  subnet_id     = "subnet-19056462"
  security_groups = ["sg-0b1fd5ccec31cb552", "sg-0525a9ccef62bba8d"]

  root_block_device {
    volume_size = "100"
    volume_type = "gp3"
  }

  tags = {
    Name = "ARM AGW 9"
  }
}
