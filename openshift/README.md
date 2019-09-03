# OpenShift OKD on Exoscale
Scripts to provision OpenShift OKD cluster using [Terraform](https://www.terraform.io) and [OpenShift](https://github.com/openshift/openshift-ansible) projects.
* `OpenShift` version: `v3.11.0`
* Underlying operating system: `Linux CentOS 7.6 64-bit`

## Workflow
* Create `terraform.tfvars` file
* Run Terraform scripts
* Set up OpenShift `inventory` file
* Run OpenShift Ansible playbooks

## Prerequisites
* Install Terraform:
    * [Terraform](https://www.terraform.io/downloads.html)
* Install following Python packages:
    * `ansible` (higher then 2.6.0, 2.7.0 does not work)
    * `hvac`
    * `jinja2` (higher then 2.7)
    * `jmespath`
    * `netaddr`
    * `passlib`
    * `pbr` (higher then 1.6)
* If you want to deploy `metrics-server` on OpenShift cluster, install following packages:
    * `httpd-tools`
    * `java-1.8.0-openjdk-headless`
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

# OpenShift variables
zone = "Exoscale zone for spinning up VMs (default to at-vie-1)"
master_count = "Number of OpenShift master nodes (default to 3)"
master_size = "Instance size for OpenShift master nodes (default to "Huge")"
master_disk = "Disk size for OpenShift master nodes (default to 100)"
infra_count = "Number of OpenShift infra nodes (default to 2)"
infra_size = "Instance size for OpenShift infra nodes (default to "Huge")"
infra_disk = "Disk size for OpenShift infra nodes (default to 200)"
node_count = "Number of OpenShift worker nodes (default to 3)"
node_size = "Instance size for OpenShift worker nodes (default to "Huge")"
node_disk = "Disk size for OpenShift worker nodes (default to 400)"
lb_count = "Number of OpenShift loadbalancer nodes (default to 1)"
lb_size = "Instance size for OpenShift loadbalancer nodes (default to "Huge")"
lb_disk = "Disk size for OpenShift loadbalancer nodes (default to 20)"
```

In case domain already exists, remove `dns` folder and module `dns` in `main.tf`.

With this, everything should be set up. Go to `/terraform` root directory and run `terraform init`. This will initialize Terraform environment. Output should be similar to this:
```
Initializing modules...
- dns in dns
- openshift in openshift
- ssh in ssh

Initializing the backend...

Initializing provider plugins...
- Checking for available provider plugins...
- Downloading plugin for provider "template" (terraform-providers/template) 2.1.2...
- Downloading plugin for provider "exoscale" (terraform-providers/exoscale) 0.12.1...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.exoscale: version = "~> 0.12"
* provider.template: version = "~> 2.1"

Terraform has been successfully initialized!
```

Next run `make create-infrastructure` and follow procedure (in case SSH keypair does not exist, run `make create-ssh-keypair` beforehand).

If all goes well, Terraform should report success message and your VMs are ready to install Openshift.

## Bootstrap OpenShift OKD Cluster
Script uses [OpenShift playbooks](https://github.com/openshift/openshift-ansible) for setting up OpenShift OKD cluster.

Move to `openshift` directory and update `.exokube.rc` and `inventory` files.
* Update `.exokube.rc` based on your desired configuration
* Update `inventory` file based on instructions within file. As a sample configuration, `inventory.sample` is provided

OpenShift settings are passed to Ansible playbooks via `inventory` file. In case of any parameter modifications, just adjust `inventory`. For more details and additional parameters, check official OpenShift [documentation](https://docs.okd.io/3.11/install/configuring_inventory_file.html).

For OpenShift installation, hosts need to be set up before OpenShift can be installed - this is done with `prerequisites.yml` playbook. After that OpenShift can be deployed using `deploy_cluster.yml` playbook. They can be invoked using `Make`:
* `make prepare` to prepare hosts for OpenShift installation
* `make deploy` to deploy OpenShift cluster

Now your cluster is ready and you can access it via `oc` from one of master nodes.

## To Do List
* automation of Ansible inventory file generation
* set up post-install scripts (fixups, oc-config, specific deployments)
* set up storage of `.tfstate` file on Exoscale Simple Object Storage

## Credits
* Maintainer: [Bostjan Bozic](https://github.com/BostjanBozic)
* Thanks to [Oliver Moser](https://github.com/olmoser), as large part of code is built on top of his contribution
