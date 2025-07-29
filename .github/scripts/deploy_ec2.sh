EC2_USER="ubuntu"
EC2_HOST="<EC2_PUBLIC_IP>"
KEY="your-key.pem"
 
ssh -i $KEY $EC2_USER@$EC2_HOST << EOF
  sudo yum install git docker -y
  sudo service docker start
  sudo usermod -aG docker ec2-user
  if [ ! -d "flask-devops-demo" ]; then
git clone https://github.com/<your-github-username>/flask-devops-demo.git
  else
      cd flask-devops-demo && git pull
  fi
  cd flask-devops-demo
  docker build -t flask-demo .
  docker stop flask-demo || true
  docker run -d -p 80:5000 --name flask-demo flask-demo
EOF