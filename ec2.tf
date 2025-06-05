resource "aws_instance" "bayer_instance" {
  ami           = "ami-0af9569868786b23a"
  instance_type = "t2.micro"
  tags = {
    Name = "Lambada-start-stop-instance"
  }
}


