# Web Server (Public EC2)
resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = "t3.micro"

  subnet_id = var.public_subnet_id

  iam_instance_profile = var.instance_profile_name

  vpc_security_group_ids = [var.web_sg_id]

  associate_public_ip_address = true

  tags = {
    Name = "web-server"
  }
}

# App Server (Private EC2)
resource "aws_instance" "app" {
  ami           = var.ami
  instance_type = "t3.micro"

  subnet_id = var.private_subnet_id

  iam_instance_profile = var.instance_profile_name

  vpc_security_group_ids = [var.app_sg_id]

  tags = {
    Name = "app-server"
  }
}