#!/bin/bash

EC2_USER="ubuntu"            
EC2_HOST="13.235.82.253"    
KEY="C:\Users\manas\Downloads\private_key.pem"      

ssh -i $KEY $EC2_USER@$EC2_HOST << EOF
  # Update system and install required packages
  sudo apt update -y
  sudo apt install -y git docker.io

  # Start Docker service and enable on boot
  sudo systemctl start docker
  sudo systemctl enable docker
  sudo usermod -aG docker ubuntu

  # Pull or update your repository
  if [ ! -d "app-devops1" ]; then
      git clone https://github.com/ishika-iisc/app-devops1.git
  else
      cd app-devops1 && git pull
  fi

  # Navigate to project and build Docker image
  cd app-devops1
  docker build -t flask-demo .

  # Stop and remove old container if exists
  docker stop flask-demo || true
  docker rm flask-demo || true

  # Run new container on port 80 -> 5000
  docker run -d -p 80:5000 --name flask-demo flask-demo:latest
EOF
