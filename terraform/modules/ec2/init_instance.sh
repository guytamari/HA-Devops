#!/bin/bash
sudo yum install -y amazon-linux-extras
sudo yum update -y
sudo amazon-linux-extras enable docker
sudo yum install -y docker
sudo systemctl enable --now docker
sudo usermod -aG docker ec2-user
sudo docker run -p 80:80 -d --pull always guytamari/nginx-custom

