# main.tf

# Provider Configuration
provider "aws" {
  region = "eu-west-1"   # Ireland region
}

# Automatically find latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Security Group - open SSH (22) and HTTP (80)
resource "aws_security_group" "web_sg" {
  name_prefix = "web-sg-"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#  Create EC2 Instance using the latest AMI
resource "aws_instance" "web_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
  security_groups = [aws_security_group.web_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              # Update the system
              sudo yum update -y

              # Install and start Apache
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd

              # Install Docker
              sudo yum install -y docker
              sudo systemctl start docker
              sudo systemctl enable docker

              # Add ec2-user to docker group to allow running Docker without sudo
              sudo usermod -aG docker ec2-user

              # Reload group membership without logout
              newgrp docker

              # Create a simple web page
              echo "<html><body><h1>Hello from AWS EC2 Docker Server!</h1><p>Server is up and running.</p></body></html>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "TerraformWebServer"
  }
}

#  Output the public IP after creation
output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.web_server.public_ip
}
