provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "ami-02a53b0d62d37a757"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0532430b0bb328b7a"

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl enable httpd
              sudo systemctl start httpd
              echo "Welcome to AWS Frontend" > /var/www/html/index.html
              EOF

  tags = {
    Name = "Frontend using aws"
  }
}

resource "aws_elb" "web_elb" {
  name               = "web-elb"
  availability_zones = ["us-east-1a"]
  subnets            = ["subnet-091689872133bc771", "subnet-0532430b0bb328b7a"]

  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }

  instances = [aws_instance.web.id]
}
 
