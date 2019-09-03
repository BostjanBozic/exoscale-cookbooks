# GlusterFS on Exoscale
Scripts to provision GlusterFS cluster using [Terraform](https://www.terraform.io) and [Ansible](https://www.ansible.com/) projects.
* `GlusterFS` version: `v6.0`
* Underlying operating system: `Linux CentOS 7.6 64-bit`

## Workflow
* Create `terraform.tfvars` file
* Run Terraform scripts
* Set up GlusterFS `inventory` file
* Run GlusterFS Ansible playbook

## Prerequisites
* Install Terraform:
    * [Terraform](https://www.terraform.io/downloads.html)
* Install following Python packages:
    * `ansible` (higher then 2.6.0, 2.7.0 does not work)
    * `hvac`
    * `jinja2` (higher then 2.7.0)
    * `jmespath`
    * `netaddr`
    * `pbr` (higher then 1.6)
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
node_disk = "Disk size for GlusterFS nodes (default to 800)"
gluster_version = "Version of GlusterFS to be used (default to 6)"
```

In case domain already exists, remove `dns` folder and module `dns` in `main.tf`.

With this, everything should be set up. Go to `/terraform` root directory and run `terraform init`. This will initialize Terraform environment. Output should be similar to this:
```
Initializing modules...
- dns in dns
- glusterfs in glusterfs
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

Next run `make create-infrastructure` and follow procedure.

If all goes well, Terraform should report success message and your VMs are ready to set up GlusterFS cluster (sometimes packages are not installed, even if VM is available; check if `gluster` binary is available on machines before bootstraping cluster).

## Bootstrap GlusterFS Cluster
Script uses [gluster_volume Ansible module](https://docs.ansible.com/ansible/latest/modules/gluster_volume_module.html) for setting up GlusterFS cluster.

Move to `glusterfs` directory and update `inventory` file.
* Update `inventory` file based on instructions within file. As a sample configuration, `inventory.sample` is provided

GlusterFS settings are passed to Ansible playbooks via `group_vars/all.yml` file. In case of any parameter modifications, just adjust it. For more details and additional parameters, check [documentation](https://docs.ansible.com/ansible/latest/modules/gluster_volume_module.html).

GlusterFS cluster can be deployed using `playbooks/deploy.yml` playbook. This can be invoked using `Make`:
* `make configure` to configure GlusterFS cluster

In case playbook fails at step `Set up GlusterFS volume`, just run playbook again.

Now your cluster is ready to use.

## To Do List
* automation of Ansible inventory file generation
* set up remote-mount playbook
* set up storage of `.tfstate` file on Exoscale Simple Object Storage

## Credits
* Maintainer: [Bostjan Bozic](https://github.com/BostjanBozic)
