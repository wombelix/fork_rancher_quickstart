# Fork / Backports

The `backports` branch of this fork contains open pull requests from [upstream](https://github.com/rancher/quickstart) to fix bugs and add features.

Feel free to use it until the pending PRs are merged and this branch becomes obsolete.

Included Patches:
- [fix(rancher-common): Helm error, could not download chart](https://github.com/rancher/quickstart/pull/238)
- [feat(rancher/aws): Use AWS env vars, use null defaults](https://github.com/rancher/quickstart/pull/239)
- [feat(rancher/aws): Bump rancher, rke2, k3s, cert-manager version](https://github.com/rancher/quickstart/pull/240)
- [feat(rancher): Use latest SLES 15 SP6 PAYG AMI](https://github.com/rancher/quickstart/pull/241)
- [feat(rancher): AWS - Switch Rancher Server public ip to EIP](https://github.com/rancher/quickstart/pull/243)
- [fix(rancher): AWS - destroy helm_release.cert_manager timeout](https://github.com/rancher/quickstart/pull/245)
- [feat(rancher): AWS - Variable to adjust security group ingress cidr](https://github.com/rancher/quickstart/pull/246)
- [fix: windows ami does not exist](https://github.com/rancher/quickstart/pull/236) (with changes: [e38d45f](https://github.com/rancher/quickstart/commit/e38d45fa4201506551aa5289de731ff80ecbba90)]

---

# Quickstart examples for the Rancher by SUSE product portfolio

Quickly stand up an HA-style installation of Rancher by SUSE products on your infrastructure provider of choice.

Intended for experimentation/evaluation ONLY.

**You will be responsible for any and all infrastructure costs incurred by these resources.**
As a result, this repository minimizes costs by standing up the minimum required resources for a given provider.
Use Vagrant to run Rancher locally and avoid cloud costs.

## Rancher Management Server quickstart

Rancher Management Server Quickstarts are provided for:

### Cloud quickstart

- [**Amazon Web Services** (`aws`)](./rancher/aws)
- [**Microsoft Azure Cloud** (`azure`)](./rancher/azure)
- [**DigitalOcean** (`do`)](./rancher/do)
- [**Google Cloud Platform** (`gcp`)](./rancher/gcp)
- [**Harvester** (`harvester`)](./rancher/harvester)
- [**Hetzner Cloud** (`hcloud`)](./rancher/hcloud)
- [**Linode** (`linode`)](./rancher/linode)
- [**Scaleway** (`scw`)](./rancher/scw)
- [**Outscale** (`outscale`)](./rancher/outscale)

**You will be responsible for any and all infrastructure costs incurred by these resources.**

Each quickstart will install Rancher on a single-node K3s cluster, then will provision another single-node RKE2 workload cluster using a Custom cluster in Rancher.
This setup provides easy access to the core Rancher functionality while establishing a foundation that can be easily expanded to a full HA Rancher server.

### Local quickstart

A local quickstart is provided in the form of Vagrant configuration.

**The Vagrant quickstart does not currently follow Rancher best practices for installing a Rancher management server.**
Use this configuration only to evaluate the features of Rancher.
See cloud provider quickstarts for an HA foundation according to Rancher installation best practices.

## NeuVector quickstart

NeuVector Quickstarts are provided for:

- [**Amazon Web Services for NeuVector** (`aws`)](./neuvector/aws)

**You will be responsible for any and all infrastructure costs incurred by these resources.**

Each quickstart will install NeuVector on a single-node RKE2 cluster. Optionally, a Rancher Management Server can be deployed as well.
This setup provides easy access to the NeuVector Rancher functionality while establishing a foundation that can be easily expanded to a full HA NeuVector installation.

## Requirements - Vagrant (local)

- [Vagrant](https://www.vagrantup.com)
- [VirtualBox](https://www.virtualbox.org)
- 6GB unused RAM

### Using Vagrant quickstarts

See [/vagrant](./vagrant) for details on usage and settings.

## Requirements - Cloud

- Terraform >=1.0.0
- Credentials for the cloud provider used for the quickstart

### Using cloud quickstarts

To begin with any quickstart, perform the following steps:

1. Clone or download this repository to a local folder
2. Choose a cloud provider and navigate into the provider's folder
3. Copy or rename `terraform.tfvars.example` to `terraform.tfvars` and fill in all required variables
4. Run `terraform init`
5. Run `terraform apply`

When provisioning has finished, terraform will output the URL to connect to the Rancher server.
Two sets of Kubernetes configurations will also be generated:
- `kube_config_server.yaml` contains credentials to access the cluster supporting the Rancher server
- `kube_config_workload.yaml` contains credentials to access the provisioned workload cluster

For more details on each cloud provider, refer to the documentation in their respective folders.

### Remove

When you're finished exploring the Rancher server, use terraform to tear down all resources in the quickstart.

**NOTE: Any resources not provisioned by the quickstart are not guaranteed to be destroyed when tearing down the quickstart.**
Make sure you tear down any resources you provisioned manually before running the destroy command.

Run `terraform destroy -auto-approve` to remove all resources without prompting for confirmation.
