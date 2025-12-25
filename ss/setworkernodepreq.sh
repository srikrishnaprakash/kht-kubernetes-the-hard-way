#!/bin/bash
sudo apt update && apt upgrade -y
sudo apt install openssh-server net-tools sshpass -y &
sudo apt install snapd terminator vim -y  &
sudo snap install kubectl --classic &
sudo sed -i 's/^#*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
ssh-keygen -t ecdsa -N "" -f ~/.ssh/id_ecdsa
sudo systemctl enable sshd &
sudo chown -R ubuntu /var/lib/kubelet/kubeconfig
sudo chown -R ubuntu /var/lib/kubelet/kube-proxy
sudo chown -R ubuntu /etc/kubernetes
chmod 755 /home/ubuntu/lksw/ss/*
echo "Provide the password for the user root"
sudo passwd root