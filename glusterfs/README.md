# GlusterFS on Exoscale
Scripts to provision GlusterFS cluster using [Terraform](https://www.terraform.io) and [Ansible](https://www.ansible.com/) projects.
* `GlusterFS` version: `v6.0`
* Underlying operating system: `Linux RedHat 7.6 64-bit`

## Workflow
* Create `terraform.tfvars` file
* Run Terraform scripts
* Set up GlusterFS `inventory` file
* Run GlusterFS Ansible playbook

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
node_count = "Number of GlusterFS nodes (default to 3)"
node_size = "Instance size for GlusterFS nodes (default to "Extra-large")"
node_disk = "Disk size for Openshift worker nodes (default to 800)"
gluster_version = "Version of GlusterFS to be used (default to 6)"
```

In case domain already exists, remove `dns` folder and module `dns` in `main.tf`.

With this, everything should be set up. Go to `/terraform` root directory and run `terraform init`. This will initialize Terraform environment. Output should be similar to this:
```
Initializing modules...
- module.ssh
  Getting source "ssh"
- module.dns
  Getting source "dns"
- module.glusterfs
  Getting source "glusterfs"

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

If all goes well, Terraform should report success message and your VMs are ready to set up GlusterFS cluster.

## Bootstrap GlusterFS Cluster
Script uses [gluster_volume Ansible module](https://docs.ansible.com/ansible/latest/modules/gluster_volume_module.html) for setting up GlusterFS cluster.

Move to `glusterfs` directory and update `inventory` file.
* Update `inventory` file based on instructions within file. As a sample configuration, `inventory.sample` is provided

GlusterFS settings are passed to Ansible playbooks via `group_vars/all.yml` file. In case of any parameter modifications, just adjust it. For more details and additional parameters, check [documentation](https://docs.ansible.com/ansible/latest/modules/gluster_volume_module.html).

GlusterFS cluster can be deployed using `playbooks/deploy.yml` playbook. This can be invoked using `Make`:
* `make configure` to configure GlusterFS cluster

Now your cluster is ready to use.

## To Do List
* automation of Ansible inventory file generation
* set up remote-mount playbook
* set up storage of `.tfstate` file on Exoscale Simple Object Storage

## Credits
* Maintainer: [Bostjan Bozic](https://github.com/BostjanBozic)
