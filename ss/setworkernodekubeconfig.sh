#!/bin/bash
sudo mkdir /etc/kubernetes
sudo chown -R ubuntu:ubuntu /etc/kubernetes
kubectl config set-cluster sril --certificate-authority=/var/lib/kubelet/ca.crt --embed-certs=true \
    --server=https://server.kubernetes.local:6443 --kubeconfig=/etc/kubernetes/kubelet.conf

kubectl config set-credentials system:node:node-0 --client-certificate=/var/lib/kubelet/node-0.crt \
  --client-key=/var/lib/kubelet/node-0.key --embed-certs=true --kubeconfig=/etc/kubernetes/kubelet.conf

kubectl config set-context default --cluster=sril --user=system:node:node-0 --kubeconfig=/etc/kubernetes/kubelet.conf

kubectl config use-context default --kubeconfig=/etc/kubernetes/kubelet.conf

sudo mkdir -p /var/lib/kubelet/config/kube-proxy
sudo chown -R ubuntu:ubuntu /var/lib/kubelet/config/kube-proxy

kubectl config set-cluster sril --certificate-authority=/var/lib/kubelet/ca.crt  --embed-certs=true \
    --server=https://server.kubernetes.local:6443 --kubeconfig=/var/lib/kubelet/config/kube-proxy/kubeconfig.conf

kubectl config set-credentials system:kube-proxy \
  --client-certificate=/var/lib/kubelet/kube-proxy.crt --client-key=/var/lib/kubelet/kube-proxy.key \
  --embed-certs=true --kubeconfig=/var/lib/kubelet/config/kube-proxy/kubeconfig.conf

kubectl config set-context default --cluster=sril --user=system:kube-proxy \
	--kubeconfig=/var/lib/kubelet/config/kube-proxy/kubeconfig.conf

kubectl config use-context default --kubeconfig=/var/lib/kubelet/config/kube-proxy/kubeconfig.conf
