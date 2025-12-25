# Bootstrapping the etcd Cluster

Kubernetes components are stateless and store cluster state in [etcd](https://github.com/etcd-io/etcd). In this lab you will bootstrap a single node etcd cluster.

## Prerequisites

Copy `etcd` binaries and systemd unit files to the `server` machine:

```bash
scp \
  downloads/controller/etcd \
  downloads/client/etcdctl \
  units/etcd.service \
  root@server:~/
```

The commands in this lab must be run on the `server` machine. Login to the `server` machine using the `ssh` command. Example:

```bash
ssh root@server
```

## Bootstrapping an etcd Cluster

### Install the etcd Binaries

Extract and install the `etcd` server and the `etcdctl` command line utility:

```bash
{
  mv etcd etcdctl /usr/local/bin/
}
```

### Configure the etcd Server

```bash
{
  mkdir -p /etc/etcd /var/lib/etcd
  chmod 700 /var/lib/etcd
  cp ca.crt kube-api-server.key kube-api-server.crt \
    /etc/etcd/
}
```

Each etcd member must have a unique name within an etcd cluster. Set the etcd name to match the hostname of the current compute instance:

Create the `etcd.service` systemd unit file:

```bash
mv etcd.service /etc/systemd/system/
```

### Start the etcd Server

```bash
{
  systemctl daemon-reload
  systemctl enable etcd
  systemctl start etcd
}
```

## Verification

List the etcd cluster members:

```bash
etcdctl member list
```

```text
6702b0a34e2cfd39, started, controller, http://127.0.0.1:2380, http://127.0.0.1:2379, false
```

Next: [Bootstrapping the Kubernetes Control Plane](08-bootstrapping-kubernetes-controllers.md)
# Links

[Prerequisites](01-prerequisites.md)&emsp;&emsp;[Setting up Jumpbox](02-jumpbox.md)&emsp;&emsp;[Provisioning Compute Resources](03-compute-resources.md)

[Provisioning  CA and Generating TLS Certificates](04-certificate-authority.md)&emsp;&emsp;[Generating Kubernetes Configuration Files for Authentication](05-kubernetes-configuration-files.md)

[Generating the Data Encryption Config and Key](06-data-encryption-keys.md)&emsp;&emsp;[Bootstrapping the etcd Cluster](07-bootstrapping-etcd.md)

[Bootstrapping the Kubernetes Worker Nodes](09-bootstrapping-kubernetes-workers.md)&emsp;&emsp;[Configuring kubectl for Remote Access](10-configuring-kubectl.md)

[Provisioning Pod Network Routes](11-pod-network-routes.md)&emsp;&emsp;[Smoke Test](12-smoke-test.md)&emsp;&emsp;[Cleaning Up](13-cleanup.md)