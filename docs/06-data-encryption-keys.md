# Generating the Data Encryption Config and Key

Kubernetes stores a variety of data including cluster state, application configurations, and secrets. Kubernetes supports the ability to [encrypt](https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data) cluster data at rest.

In this lab you will generate an encryption key and an [encryption config](https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/#understanding-the-encryption-at-rest-configuration) suitable for encrypting Kubernetes Secrets.

## The Encryption Key

Generate an encryption key:

```bash
export ENCRYPTION_KEY=$(head -c 32 /dev/urandom | base64)
```

## The Encryption Config File

Create the `encryption-config.yaml` encryption config file:

```bash
envsubst < configs/encryption-config.yaml \
  > encryption-config.yaml
```

Copy the `encryption-config.yaml` encryption config file to each controller instance:

```bash
scp encryption-config.yaml root@server:~/
```

Next: [Bootstrapping the etcd Cluster](07-bootstrapping-etcd.md)
# Links

[Prerequisites](01-prerequisites.md)&emsp;&emsp;[Setting up Jumpbox](02-jumpbox.md)&emsp;&emsp;[Provisioning Compute Resources](03-compute-resources.md)

[Provisioning  CA and Generating TLS Certificates](04-certificate-authority.md)&emsp;&emsp;[Generating Kubernetes Configuration Files for Authentication](05-kubernetes-configuration-files.md)

[Generating the Data Encryption Config and Key](06-data-encryption-keys.md)&emsp;&emsp;
[Bootstrapping the Kubernetes Control Plane](08-bootstrapping-kubernetes-controllers.md)

[Bootstrapping the Kubernetes Worker Nodes](09-bootstrapping-kubernetes-workers.md)&emsp;&emsp;[Configuring kubectl for Remote Access](10-configuring-kubectl.md)

[Provisioning Pod Network Routes](11-pod-network-routes.md)&emsp;&emsp;[Smoke Test](12-smoke-test.md)&emsp;&emsp;[Cleaning Up](13-cleanup.md)