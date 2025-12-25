# Cleaning Up

In this lab you will delete the compute resources created during this tutorial.

## Compute Instances

Previous versions of this guide made use of GCP resources for various aspects of compute and networking. The current version is agnostic, and all configuration is performed on the `jumpbox`, `server`, or nodes.

Clean up is as simple as deleting all virtual machines you created for this exercise.

# Links

[Prerequisites](01-prerequisites.md)&emsp;&emsp;[Setting up Jumpbox](02-jumpbox.md)&emsp;&emsp;[Provisioning Compute Resources](03-compute-resources.md)

[Provisioning  CA and Generating TLS Certificates](04-certificate-authority.md)&emsp;&emsp;[Generating Kubernetes Configuration Files for Authentication](05-kubernetes-configuration-files.md)

[Generating the Data Encryption Config and Key](06-data-encryption-keys.md)&emsp;&emsp;[Bootstrapping the etcd Cluster](07-bootstrapping-etcd.md)

[Bootstrapping the Kubernetes Control Plane](08-bootstrapping-kubernetes-controllers.md)&emsp;&emsp;  [Bootstrapping the Kubernetes Worker Nodes](09-bootstrapping-kubernetes-workers.md)

[Configuring kubectl for Remote Access](10-configuring-kubectl.md)&emsp;&emsp;[Provisioning Pod Network Routes](11-pod-network-routes.md)&emsp;&emsp;[Smoke Test](12-smoke-test.md)
