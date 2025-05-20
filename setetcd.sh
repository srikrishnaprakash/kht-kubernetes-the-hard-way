#!/usr/bin/env bash
wget wget https://github.com/etcd-io/etcd/releases/download/v3.6.0-rc.3/etcd-v3.6.0-rc.3-linux-amd64.tar.gz -O ~/tmp/etcd-v3.6.0.tar.gz
tar -xvzf ~/tmp/etcd-v3.6.0.tar.gz --strip-components 1 etcd-v3.6.0-rc.3-linux-amd64/etcdctl  etcd-v3.6.0-rc.3-linux-amd64/etcd -C ~/tmp/
sudo mv ~/tmp/etcd /usr/local/bin/
sudo mv ~/tmp/etcdctl /usr/local/bin/
sudo chmod 755 /usr/local/bin/etcd
sudo chmod 755 /usr/local/bin/etcdctl
sudo mkdir -p /etc/etcd /var/lib/etcd
sudo chmod 700 /var/lib/etcd
sudo cp certs/ca.crt certs/kube-api-server.key certs/kube-api-server.crt /etc/etcd/
sudo cp units/etcd.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable etcd
sudo systemctl start etcd
sudo rm ~/tmp/etcd-v3.6.0.tar.gz
etcdctl member list