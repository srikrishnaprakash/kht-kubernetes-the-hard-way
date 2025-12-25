#!/usr/bin/env bash
for HOST in node-0; do
  SUBNET=$(grep ${HOST} ~/tmp/macs.txt | cut -d " " -f 4)
  sed "s|SUBNET|$SUBNET|g" configs/10-bridge.conf > 10-bridge.conf
  sed "s|SUBNET|$SUBNET|g" configs/kubelet-config.yaml > kubelet-config.yaml

  scp 10-bridge.conf kubelet-config.yaml root@${HOST}:~/
done
mkdir -p ~/tmp/worker
mkdir -p ~/tmp/cni-plugins

wget https://github.com/kubernetes-sigs/cri-tools/releases/download/v1.32.0/crictl-v1.32.0-linux-amd64.tar.gz -O ~/tmp/crictl-v1.32.0.tar.gz
wget https://github.com/containerd/containerd/releases/download/v2.1.0-beta.0/containerd-2.1.0-beta.0-linux-amd64.tar.gz -O ~/tmp/containerd-2.1.0.tar.gz
wget https://github.com/containernetworking/plugins/releases/download/v1.6.2/cni-plugins-linux-amd64-v1.6.2.tgz -O ~/tmp/cni-plugins-v1.6.2.tgz
wget https://github.com/opencontainers/runc/releases/download/v1.3.0-rc.1/runc.amd64 -O ~/tmp/runc
wget https://dl.k8s.io/v1.32.3/bin/linux/amd64/kube-proxy -O ~/tmp/worker/kube-proxy
wget https://dl.k8s.io/v1.32.3/bin/linux/amd64/kubelet -O ~/tmp/worker/kubelet

tar -xvzf ~/tmp/crictl-v1.32.0.tar.gz -C ~/tmp/worker/
tar -xvzf ~/tmp/containerd-2.1.0.tar.gz --strip-components 1 -C ~/tmp/worker/
tar -xvzf ~/tmp/cni-plugins-v1.6.2.tgz -C ~/tmp/cni-plugins/

for HOST in node-0; do
  scp ~/tmp/worker/* ~/tmp/kubectl configs/99-loopback.conf root@${HOST}:~/
  scp configs/containerd-config.toml configs/kube-proxy-config.yaml root@${HOST}:~/
  scp units/containerd.service units/kubelet.service units/kube-proxy.service root@${HOST}:~/
done

for HOST in node-0; do
  scp ~/tmp/cni-plugins/* root@${HOST}:~/cni-plugins/
  ssh -n root@${HOST} "apt-get update"
  ssh -n root@${HOST} "apt-get -y install socat conntrack ipset kmod"
  ssh -n root@${HOST} "swapoff -a"
  ssh -n root@${HOST} "mkdir -p /etc/cni/net.d /opt/cni/bin /opt/cni/bin"
  ssh -n root@${HOST} "mkdir -p /var/lib/kubelet /var/lib/kube-proxy /var/lib/kubernetes /var/run/kubernetes"
  ssh -n root@${HOST} "mv crictl kube-proxy kubelet runc /usr/local/bin/"
  ssh -n root@${HOST} "mv containerd containerd-shim-runc-v2 containerd-stress /bin/"
  ssh -n root@${HOST} "mv cni-plugins/* /opt/cni/bin/"
  ssh -n root@${HOST} "mv 10-bridge.conf /etc/cni/net.d/"
  ssh -n root@${HOST} "modprobe br-netfilter && echo "br-netfilter" >> /etc/modules-load.d/modules.conf"
  ssh -n root@${HOST} "echo "net.bridge.bridge-nf-call-iptables = 1" >> /etc/sysctl.d/kubernetes.conf"
  ssh -n root@${HOST} "echo "net.bridge.bridge-nf-call-ip6tables = 1" >> /etc/sysctl.d/kubernetes.conf"
  ssh -n root@${HOST} "sysctl -p /etc/sysctl.d/kubernetes.conf"
  ssh -n root@${HOST} "mkdir -p /etc/containerd/"
  ssh -n root@${HOST} "mv containerd-config.toml /etc/containerd/config.toml"
  ssh -n root@${HOST} "mv containerd.service /etc/systemd/system/"
done

for HOST in node-0; do
  ssh -n root@${HOST} "mv kubelet-config.yaml /var/lib/kubelet/"
  ssh -n root@${HOST} "mv kubelet.service /etc/systemd/system/"
  ssh -n root@${HOST} "mv kubelet-config.yaml /var/lib/kubelet/"
  ssh -n root@${HOST} "mv kubelet.service /etc/systemd/system/"
  ssh -n root@${HOST} "mv kube-proxy-config.yaml /var/lib/kube-proxy/"
  ssh -n root@${HOST} "mv kube-proxy.service /etc/systemd/system/"
  ssh -n root@${HOST} "systemctl daemon-reload"
  ssh -n root@${HOST} "systemctl enable containerd kubelet kube-proxy"
  ssh -n root@${HOST} "systemctl start containerd kubelet kube-proxy"
  ssh -n root@${HOST} "
}
done