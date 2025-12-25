#!/bin/bash
sudo mkdir /etc/kubernetes/













for host in node-0; do
  ssh root@${host} "mkdir -p /var/lib/{kube-proxy,kubelet}"
  scp kube-proxy.kubeconfig \
    root@${host}:/var/lib/kube-proxy/kubeconfig \

  scp ${host}.kubeconfig \
    root@${host}:/var/lib/kubelet/kubeconfig
done


sudo cp admin.kubeconfig kube-controller-manager.kubeconfig kube-scheduler.kubeconfig ~/