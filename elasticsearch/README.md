# Elasticsearch on Exoscale
Scripts to provision Elasticsearch cluster using [Terraform](https://www.terraform.io) and [Ansible](https://www.ansible.com/) projects.
* `Elasticsearch` version: `v6.6.0`
* `Kibana` version: `v6.6.0`
* Underlying operating system: `Linux RedHat 7.6 64-bit`

## Workflow
* Create `terraform.tfvars` file
* Run Terraform scripts
* Set up Elasticsearch `inventory` file
* Run Elasticsearch Ansible playbook

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
master_count = "Number of Elasticsearch master nodes (default to 2)"
master_size = "Instance size for Elasticsearch master nodes (default to "Medium")"
master_disk = "Disk size for Elasticsearch master nodes (default to 100)"
data_count = "Number of Elasticsearch data nodes (default to 4)"
data_size = "Instance size for Elasticsearch data nodes (default to "Huge")"
data_disk = "Disk size for Elasticsearch data nodes (default to 800)"
ingest_count = "Number of Elasticsearch ingest nodes (default to 1)"
ingest_size = "Instance size for Elasticsearch ingest nodes (default to "Huge")"
ingest_disk = "Disk size for Elasticsearch ingest nodes (default to 400)"
```

In case domain already exists, remove `dns` folder and module `dns` in `main.tf`.

With this, everything should be set up. Go to `/terraform` root directory and run `terraform init`. This will initialize Terraform environment. Output should be similar to this:
```
Initializing modules...
- module.ssh
  Getting source "ssh"
- module.dns
  Getting source "dns"
- module.elasticsearch
  Getting source "elasticsearch"

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

If all goes well, Terraform should report success message and your VMs are ready to set up Elasticsearch cluster.

## Bootstrap Elasticsearch Cluster
Script uses [elastic.elasticsearch Ansible role](https://galaxy.ansible.com/elastic/elasticsearch) for setting up Elasticsearch cluster and [jtyr.kibana Ansible role](https://github.com/jtyr/ansible-kibana) for setting up Kibana.

Move to `elasticsearch` directory and update `inventory` file.
* Update `inventory` file based on instructions within file. As a sample configuration, `inventory.sample` is provided

Elasticsearch settings are passed to Ansible playbooks via `group_vars/all.yml` file. In case of any parameter modifications, just adjust it. For more details and additional parameters, check [Elasticsearch role](https://galaxy.ansible.com/elastic/elasticsearch) and [Kibana role](https://github.com/jtyr/ansible-kibana).

Elasticsearch cluster can be deployed using `playbooks/deploy.yml` playbook. This can be invoked using `Make`:
* `make deploy-es` to deploy Elasticsearch cluster
* `make deploy-master` to deploy only Elasticsearch master nodes
* `make deploy-data` to deploy only Elasticsearch data nodes
* `make deploy-ingest` to deploy only Elasticsearch ingest nodes

Now your cluster is ready to use.

For handling Kibana configuration, `playbooks/kibana.yml` playbook is used. Following `Make` targets exist:
* `make deploy-kibana` to deploy Kibana

For handling services, `playbooks/service.yml` playbook is used. Following `Make` targets exist:
* `make restart-es-service` to restart Elasticsearch service on all nodes
* `make start-es-service` to start Elasticsearch service on all nodes
* `make stop-es-service` to stop Elasticsearch service on all nodes
* `make restart-kibana-service` to restart Kibana service on Kibana nodes
* `make start-kibana-service` to start Kibana service on Kibana nodes
* `make stop-kibana-service` to stop Kibana service on Kibana nodes

## To Do List
* automation of Ansible inventory file generation
* set up storage of `.tfstate` file on Exoscale Simple Object Storage

## Credits
* Maintainer: [Bostjan Bozic](https://github.com/BostjanBozic)
