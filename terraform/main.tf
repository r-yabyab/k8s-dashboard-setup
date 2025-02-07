provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "my_instance_worker" {
  # 24.04
  ami           = "ami-0cf2b4e024cdb6960"
  # 22.04
  # ami           = "ami-0606dd43116f5ed57"
  
  instance_type = "t3.large"
  tags = {
    "Name" = "k8s-dashboard-dev-master"
  }
  key_name        = "kube-server"
  security_groups = ["k8s-dashboard-dev"]
  root_block_device {
    volume_size = 30
# 30 for k8s dashboard, 50 nephio
  }
}

output "Connect_to_node" {
  value = "ssh -i kube-server.pem ubuntu@${aws_instance.my_instance_worker.public_ip}"
  description = "Connect to node"
}

####ports (0.0.0.0/0)
#
# defaults 
#
# SSH 22
# HTTP 80
# HTTPS 443
#
# TCP 8001
# TCP 8000
# TCP 30000 - 32767
# TCP 8080
# TCP 8443