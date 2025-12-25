#!/bin/bash
sudo apt update && upgrade -y 
wait
sudo apt install openssh-server net-tools sshpass -y &
sudo apt install snapd terminator vim -y  &
sudo snap install kubectl --classic &
wait 
sudo sed -i 's/^#*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config & 
ssh-keygen -t ecdsa -N "" -f ~/.ssh/id_ecdsa
sudo mkdir -p /root/ca
chmod 766 /home/ubuntu/lksw/conf/*
sudo systemctl enable ssh &
echo "Provide the password for the user root"
sudo passwd root