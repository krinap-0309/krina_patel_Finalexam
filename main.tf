# main.tf
resource "aws_instance" "nginx_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  security_groups = [aws_security_group.nginx_sg.name]

  tags = {
    Name = "Nginx-EC2-Instance"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras enable nginx1
              yum install -y nginx
              systemctl start nginx
              systemctl enable nginx
              EOF

  lifecycle {
    create_before_destroy = true
  }

  
}
