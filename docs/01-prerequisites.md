# Prerequisites

In this lab you will review the machine requirements necessary to follow this tutorial.

## Virtual or Physical Machines

This tutorial requires four (4) virtual or physical ARM64 or AMD64 machines running Debian 12 (bookworm). The following table lists the four machines and their CPU, memory, and storage requirements.

| Name    | Description            | CPU | RAM   | Storage |
|---------|------------------------|-----|-------|---------|
| jumpbox | Administration host    | 1   | 512MB | 10GB    |
| server  | Kubernetes server      | 1   | 2GB   | 20GB    |
| node-0  | Kubernetes worker node | 1   | 2GB   | 20GB    |
| node-1  | Kubernetes worker node | 1   | 2GB   | 20GB    |

How you provision the machines is up to you, the only requirement is that each machine meet the above system requirements including the machine specs and OS version. Once you have all four machines provisioned, verify the OS requirements by viewing the `/etc/os-release` file:

```bash
cat /etc/os-release
```

You should see something similar to the following output:

```text
PRETTY_NAME="Debian GNU/Linux 12 (bookworm)"
NAME="Debian GNU/Linux"
VERSION_ID="12"
VERSION="12 (bookworm)"
VERSION_CODENAME=bookworm
ID=debian
```

Next: [Setting up Jumpbox](02-jumpbox.md)
# Links

[Provisioning Compute Resources](03-compute-resources.md)&emsp;&emsp;[Provisioning  CA and Generating TLS Certificates](04-certificate-authority.md)

[Generating Kubernetes Configuration Files for Authentication](05-kubernetes-configuration-files.md)&emsp;&emsp;[Generating the Data Encryption Config and Key](06-data-encryption-keys.md)

[Bootstrapping the etcd Cluster](07-bootstrapping-etcd.md)&emsp;&emsp;[Bootstrapping the Kubernetes Control Plane](08-bootstrapping-kubernetes-controllers.md)

[Bootstrapping the Kubernetes Worker Nodes](09-bootstrapping-kubernetes-workers.md)&emsp;&emsp;[Configuring kubectl for Remote Access](10-configuring-kubectl.md)

[Provisioning Pod Network Routes](11-pod-network-routes.md)&emsp;&emsp;[Smoke Test](12-smoke-test.md)&emsp;&emsp;[Cleaning Up](13-cleanup.md)
