#!/bin/bash

  cp /etc/kubernetes/kubelet.conf /var/lib/kubelet/kubeconfig
  cp /var/lib/kubelet/kube-proxy/kubeconfig.conf /var/lib/kubelet/kube-proxy/kubeconfig
  chown -R ubuntu /etc/kubernetes/
  chown -R ubuntu /var/lib/kubelet/
