#!/usr/bin/env bash
wget https://dl.k8s.io/v1.32.3/bin/linux/amd64/kube-apiserver -O ~/tmp/kube-apiserver
wget https://dl.k8s.io/v1.32.3/bin/linux/amd64/kube-controller-manager -O ~/tmp/kube-controller-manager
wget https://dl.k8s.io/v1.32.3/bin/linux/amd64/kube-scheduler -O ~/tmp/kube-scheduler
wget https://dl.k8s.io/v1.32.3/bin/linux/amd64/kubectl -O ~/tmp/kubectl
sudo mv ~/tmp/kube-apiserver /usr/local/bin/
sudo mv ~/tmp/kube-controller-manager /usr/local/bin/
sudo mv ~/tmp/kube-scheduler /usr/local/bin/
sudo cp ~/tmp/kubectl /usr/local/bin/
sudo chmod 755 /usr/local/bin/kube-apiserver
sudo chmod 755 /usr/local/bin/kube-controller-manager
sudo chmod 755 /usr/local/bin/kube-scheduler
sudo chmod 755 /usr/local/bin/kubectl
mkdir -p /var/lib/kubernetes/
mv certs/ca.crt certs/ca.key certs/kube-api-server.key certs/kube-api-server.crt /var/lib/kubernetes/
mv certs/service-accounts.key certs/service-accounts.crt /var/lib/kubernetes/
mv encryption-config.yaml /var/lib/kubernetes/
mv certs/kube-controller-manager.kubeconfig /var/lib/kubernetes/
mv units/kube-apiserver.service /etc/systemd/system/kube-apiserver.service

mv certs/kube-controller-manager.kubeconfig /var/lib/kubernetes/
mv units/kube-controller-manager.service /etc/systemd/system/

mv certs/kube-scheduler.kubeconfig /var/lib/kubernetes/
mv configs/kube-scheduler.yaml /etc/kubernetes/config/
mv kube-scheduler.service /etc/systemd/system/

systemctl daemon-reload
systemctl enable kube-apiserver kube-controller-manager kube-scheduler
systemctl start kube-apiserver kube-controller-manager kube-scheduler


kubectl cluster-info --kubeconfig certs/admin.kubeconfig
kubectl apply -f configs/kube-apiserver-to-kubelet.yaml --kubeconfig certs/admin.kubeconfig

curl --cacert certs/ca.crt https://server.kubernetes.local:6443/version