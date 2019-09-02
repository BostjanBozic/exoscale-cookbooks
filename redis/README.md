# Redis on Exoscale
Scripts to provision Redis in variety of configurations using [Terraform](https://www.terraform.io) and [Ansible](https://www.ansible.com/) projects.
* `Redis` version: `v5.0.4`
* Underlying operating system: `Linux CentOS 7.6 64-bit`

**Note**: Redis Sentinel deployment is currently not available.

## Workflow
* Create `terraform.tfvars` file
* Run Terraform scripts
* Set up Redis `inventory` file
* Run Redis Ansible playbook

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
master_count = "Number of Redis master nodes (default to 3)"
master_size = "Instance size for Redis master nodes (default to "Huge")"
master_disk = "Disk size for Redis master nodes (default to 100)"
replica_count = "Number of Redis replica nodes (default to 3)"
replica_size = "Instance size for Redis replica nodes (default to "Huge")"
replica_disk = "Disk size for Redis replica nodes (default to 100)"
sentinel_count = "Number of Redis Sentinel nodes (default to 3)"
sentinel_size = "Instance size for Redis Sentinel nodes (default to "medium")"
sentinel_disk = "Disk size for Redis Sentinel nodes (default to 50)"
```

In case domain already exists, remove `dns` folder and module `dns` in `main.tf`.

With this, everything should be set up. Go to `/terraform` root directory and run `terraform init`. This will initialize Terraform environment. Output should be similar to this:
```
Initializing modules...
- dns in dns
- redis in redis
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

If all goes well, Terraform should report success message and your VMs are ready to set up Redis.

## Bootstrap Elasticsearch Cluster
Script uses [BostjanBozic.redis Ansible role](https://galaxy.ansible.com/bostjanbozic/redis) for setting up Redis.

Move to `redis` directory and update `inventory` file.
* Update `inventory` file based on instructions within file. As a sample configuration, `inventory.sample` is provided

Redis cluster can be deployed using playbooks in`playbooks/` folder. This can be invoked using `Make`:
* `make deploy-single-node` to deploy Redis on single node
* `make deploy-replicated` to deploy single Redis master with multiple replicas
* `make deploy-cluster` to deploy Redis cluster with multiple masters and replicas

Now your Redis is ready to use.

## To Do List
* add Redis Sentinel to playbooks
* automation of Ansible inventory file generation
* set up storage of `.tfstate` file on Exoscale Simple Object Storage

## Credits
* Maintainer: [Bostjan Bozic](https://github.com/BostjanBozic)
