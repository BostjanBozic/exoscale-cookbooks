# Kubernetes on Exoscale
Scripts to provision Kubernetes cluster using [Terraform](https://www.terraform.io) and [Kubespray](https://github.com/kubernetes-sigs/kubespray) projects.
* `kubespray` version: `v2.9.0` (Kubernetes version `v1.13.5`)
* Underlying operating system: `Linux CoreOS 1967.5.0 64-bit`
* project by default works only with 3 `etcd` nodes, if different ammount is required, update files in `terraform/kubernetes/cloud-init` accordingly

## Workflow
* Create `terraform.tfvars` file
* Run Terraform scripts
* Set up Kubespray `inventory` file
* Run Kubespray Ansible playbooks

## Prerequisites
* Install Exoscale Terraform provider:
    * [Provider](https://github.com/exoscale/terraform-provider-exoscale)
    * [Documentation](https://www.terraform.io/docs/configuration/providers.html#third-party-plugins)
* Install following Python packages:
    * `ansible` (higher then 2.6.0, 2.7.0 does not work)
    * `jinja2` (2.8.0)
    * `netaddr`
    * `pbr` (higher then 1.6)
    * `hvac`
    * `jmespath`
* Register domain
* Generate SSH keypair (`ssh-keygen`)
* Fetch Exoscale API key and Secret Key (Account > Profile > API Keys)

## Bootstrap VMs Using Terraform
Make sure you went through prerequisite steps.

First thing that needs to be set up is `terraform.tfvars` file in `/terraform` directory:
```
# Exoscale Credentials
api_key = "Your Exoscale Api key"
secret_key = "Your Exoscale Secret Key"

# SSH Keys
private_key_file = "Path to generated SSH private key"
public_key_file = "Path to generated SSH public key"

# Domain settings
domain = "Your registered domain"
domain_ttl = "Prefer TTL parameter for your domain (default to 600)"

# Connectivity settings
installer_ip = "Your host IP address with mask (x.x.x.x/x)"

# Kubernetes variables
zone = "Exoscale zone for spinning up VMs (default to at-vie-1)"
master_count = "Number of k8s master nodes (default to 3)"
master_size = "Instance size for k8s master nodes (default to "Medium")"
master_disk = "Disk size for k8s master nodes (default to 100)"
etcd_count = "Number of k8s etcd nodes (default to 3)"
etcd_size = "Instance size for k8s etcd nodes (default to "Medium")"
etcd_disk = "Disk size for k8s etcd nodes (default to 10)"
node_count = "Number of k8s worker nodes (default to 3)"
node_size = "Instance size for k8s worker nodes (default to "Huge")"
node_disk = "Disk size for k8s worker nodes (default to 400)"
```

In case domain already exists, remove `dns` folder and module `dns` in `main.tf`.

With this, everything should be set up. Go to `/terraform` root directory and run `terraform init`. This will initialize Terraform environment. Output should be similar to this:
```
Initializing modules...
- module.ssh
  Getting source "ssh"
- module.dns
  Getting source "dns"
- module.kubernetes
  Getting source "kubernetes"

Initializing provider plugins...
- Checking for available provider plugins on https://releases.hashicorp.com...
- Downloading plugin for provider "cloudstack" (0.2.0)...
- Downloading plugin for provider "template" (2.1.0)...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.cloudstack: version = "~> 0.2"
* provider.exoscale: version = "~> 0.9"
* provider.template: version = "~> 2.1"

Terraform has been successfully initialized!
```

Next run `make create-infrastructure` and follow procedure.

If all goes well, Terraform should report success message and your VMs are ready to install Kubernetes.

## Bootstrap Kubernetes Cluster
Script uses [Kubespray](https://github.com/kubernetes-sigs/kubespray) for setting up Kubernetes cluster.

Move to `kube-spray` directory and update `.exokube.rc` and `inventory` files.
* Update `.exokube.rc` based on your desired configuration
* Update `inventory` file based on instructions within file. As a sample configuration, `inventory.sample` is provided

Kubespray settings are passed to Ansible playbooks via `exokube.yml` file. In case of any parameter modifications, just adjust `exokube.yml`. For more details and additional parameters, check official Kubespray [documentation](https://github.com/kubernetes-sigs/kubespray/blob/master/docs/vars.md).

Based on your intentions, you can choose to create new cluster or scale existing one:
* `make bootstrap` to create new cluster
* `make scale` to scale existing cluster

After installation is complete, log into any master node and copy `/etc/kubernetes/admin.conf` file locally to `$HOME/.kube/config`. Now your cluster is ready and you can access it via `kubectl`.

## To Do List
* automation of Ansible inventory file generation
* set up post-install scripts (fixups, kube-config, specific deployments)
* set up storage of `.tfstate` file on Exoscale Simple Object Storage

## Credits
* Maintainer: [Bostjan Bozic](https://github.com/BostjanBozic)
* Thanks to [Oliver Moser](https://github.com/olmoser), as large part of code is built on top of his contribution
