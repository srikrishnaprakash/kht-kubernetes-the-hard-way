#!/bin/sh
apt update
apt upgrade -y 
if [ -z $1 ]; then 
	echo "Provide the logged-in username"
	exit 1
fi
sed -i 's/^root	.*/root	ALL=(ALL)	NOPASSWD: ALL /' /etc/sudoers &
echo "`date` User $1 modified the sudoer root user without passwd" >> /var/log/set-access.log
if ! command -v sshd &> /dev/null; then
	apt install openssh-server -y
	apt install net-tools snapd vim -y 
	echo "`date` Installed openssh-server, net-tools, snapd and vim..." >> /var/log/set-access.log
else
	echo "openssh-server installed already..."
fi
if [ $? -eq 0 ]; then 
	sed -i 's/^#*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config &
	echo "`date` Root login permitted thru ssh" >> /var/log/set-access.log
else
	sleep 120
fi
usermod -aG wheel $1 
passwd root
echo "`date` User root passwd updated..." >> /var/log/set-access.log