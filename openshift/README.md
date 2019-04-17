# Openshift OKD on Exoscale
Scripts to provision Openshift OKD cluster using [Terraform](https://www.terraform.io) and [Openshift](https://github.com/openshift/openshift-ansible) projects.
* `Openshift` version: `v3.11.0`
* Underlying operating system: `Linux RedHat 7.6 64-bit`

## Workflow
* Create `terraform.tfvars` file
* Run Terraform scripts
* Set up Openshift `inventory` file
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

# Openshift variables
zone = "Exoscale zone for spinning up VMs (default to at-vie-1)"
master_count = "Number of Openshift master nodes (default to 3)"
master_size = "Instance size for Openshift master nodes (default to "Huge")"
master_disk = "Disk size for Openshift master nodes (default to 100)"
infra_count = "Number of Openshift infra nodes (default to 2)"
infra_size = "Instance size for Openshift infra nodes (default to "Huge")"
infra_disk = "Disk size for Openshift infra nodes (default to 200)"
node_count = "Number of Openshift worker nodes (default to 3)"
node_size = "Instance size for Openshift worker nodes (default to "Huge")"
node_disk = "Disk size for Openshift worker nodes (default to 400)"
lb_count = "Number of Openshift loadbalancer nodes (default to 1)"
lb_size = "Instance size for Openshift loadbalancer nodes (default to "Huge")"
lb_disk = "Disk size for Openshift loadbalancer nodes (default to 20)"
```

In case domain already exists, remove `dns` folder and module `dns` in `main.tf`.

With this, everything should be set up. Go to `/terraform` root directory and run `terraform init`. This will initialize Terraform environment. Output should be similar to this:
```
Initializing modules...
- module.ssh
  Getting source "ssh"
- module.dns
  Getting source "dns"
- module.openshift
  Getting source "openshift"

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

If all goes well, Terraform should report success message and your VMs are ready to install Openshift.

## Bootstrap Openshift OKD Cluster
Script uses [Openshift playbooks](https://github.com/openshift/openshift-ansible) for setting up Openshift OKD cluster.

Move to `openshift` directory and update `.exokube.rc` and `inventory` files.
* Update `.exokube.rc` based on your desired configuration
* Update `inventory` file based on instructions within file. As a sample configuration, `inventory.sample` is provided

Openshift settings are passed to Ansible playbooks via `inventory` file. In case of any parameter modifications, just adjust `inventory`. For more details and additional parameters, check official Openshift [documentation](https://docs.okd.io/3.11/install/configuring_inventory_file.html).

For Openshift installation, hosts need to be set up before Openshift can be installed - this is done with `prerequisites.yml` playbook. After that Openshift can be deployed using `deploy_cluster.yml` playbook. They can be invoked using `Make`:
* `make prepare` to prepare hosts for Openshift installation
* `make deploy` to deploy Openshift cluster

Now your cluster is ready and you can access it via `oc` from one of master nodes.

## To Do List
* automation of Ansible inventory file generation
* set up post-install scripts (fixups, oc-config, specific deployments)
* set up storage of `.tfstate` file on Exoscale Simple Object Storage

## Credits
* Maintainer: [Bostjan Bozic](https://github.com/BostjanBozic)
* Thanks to [Oliver Moser](https://github.com/olmoser), as large part of code is built on top of his contribution
