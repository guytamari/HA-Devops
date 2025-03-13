

#!/bin/bash
# Optimized Docker installation for Ubuntu 22.04

set -eux  # Enable debugging and stop on first error

# Update package lists and install dependencies in one step
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y ca-certificates curl

# Add Docker's official GPG key and repository in one command
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/keyrings/docker.asc > /dev/null
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker in one command
sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enable and start Docker service
sudo systemctl enable --now docker

# Pull and run the Docker container in one command
docker run -p 80:80 -d --pull always guytamari/nginx-custom
