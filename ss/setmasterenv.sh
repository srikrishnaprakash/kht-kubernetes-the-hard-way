#!/bin/bash
if [ $# -eq 0 ]; then
  echo "Kindly provide the cluster name"
else
  #sudo mkdir /etc/kubernetes/ 
  sudo chown -R ubuntu /etc/kubernetes 
  sudo chmod 755 /root/*.*
  
  if [ $? -eq 0 ]; then
    echo "Setting up controller-manager kubeconfig..."
    kubectl config set-cluster chomee --certificate-authority=/root/ca.crt --embed-certs=true \
      --server=https://server.kubernetes.local:6443 --kubeconfig=/etc/kubernetes/controller-manager.conf 
    
    kubectl config set-credentials system:kube-controller-manager --embed-certs=true \
      --client-certificate=/root/kube-controller-manager.crt \
      --client-key=/root/kube-controller-manager.key --kubeconfig=/etc/kubernetes/controller-manager.conf 
    
    kubectl config set-context default --cluster=chomee --user=system:kube-controller-manager \
      --kubeconfig=kube-controller-manager.kubeconfig  

    kubectl config use-context default --kubeconfig=/etc/kubernetes/controller-manager.conf
  fi

  if [ $? -eq 0 ]; then
    echo "Setting up scheduler kubeconfig..."
    kubectl config set-cluster chomee --certificate-authority=/root/ca.crt --embed-certs=true \
      --server=https://server.kubernetes.local:6443 --kubeconfig=/etc/kubernetes/scheduler.conf 
    
    kubectl config set-credentials system:kube-scheduler --embed-certs=true \
      --client-certificate=/root/kube-scheduler.crt \
      --client-key=/root/kube-scheduler.key --kubeconfig=/etc/kubernetes/scheduler.conf 
    
    kubectl config set-context default --cluster=chomee --user=system:kube-scheduler \
      --kubeconfig=/etc/kubernetes/scheduler.conf 
    
    kubectl config use-context default --kubeconfig=/etc/kubernetes/scheduler.conf 
    
  fi

  if [ $? -eq 0 ]; then
    echo "Setting up admin kubeconfig..."
    kubectl config set-cluster chomee --certificate-authority=/root/ca.crt --embed-certs=true \
      --server=https://127.0.0.1:6443 --kubeconfig=/etc/kubernetes/admin.conf 
    
    kubectl config set-credentials admin --client-certificate=/root/admin.crt --client-key=/root/admin.key \
      --embed-certs=true --kubeconfig=/etc/kubernetes/admin.conf
    
    kubectl config set-context default --cluster=chomee --user=admin --kubeconfig=/etc/kubernetes/admin.conf 
    
    kubectl config use-context default --kubeconfig=/etc/kubernetes/admin.conf
    
  fi
  



    echo "Setting up chomee kubeconfig for worker node..."
    kubectl config set-cluster chomee --certificate-authority=/root/ca.crt --embed-certs=true \
      --server=https://server.kubernetes.local:6443 --kubeconfig=kubelet.conf 
    
    kubectl config set-credentials system:node:node-0 --client-certificate=/root/node-0.crt \
    --client-key=/root/node-0.key --embed-certs=true --kubeconfig=kubelet.conf 
    
    kubectl config set-context default --cluster=chomee --user=system:node:node-0 --kubeconfig=kubelet.conf 
    
    kubectl config use-context default --kubeconfig=kubelet.conf
 
  scp kubelet.conf root@chomee:/etc/kubernetes/

 
    echo "Setting up kube-proxy kubeconfig for worker node..."
    kubectl config set-cluster chomee --certificate-authority=/root/ca.crt  --embed-certs=true \
      --server=https://server.kubernetes.local:6443 --kubeconfig=kubeconfig.conf

    kubectl config set-credentials system:kube-proxy --embed-certs=true \
      --client-certificate=/root/kube-proxy.crt --client-key=/root/kube-proxy.key --kubeconfig=kubeconfig.conf
  
    kubectl config set-context default --cluster=chomee --user=system:kube-proxy --kubeconfig=kubeconfig.conf
    
    kubectl config use-context default --kubeconfig=kubeconfig.conf

  scp kubeconfig.conf root@chomee:/var/lib/kubelet/kube-proxy/kubeconfig.conf
fi
