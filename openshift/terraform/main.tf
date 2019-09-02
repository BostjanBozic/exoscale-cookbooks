variable "api_key" {}
variable "secret_key" {}
variable "private_key_file" {}
variable "public_key_file" {}
variable "installer_ip" {}

variable "domain" {}
variable "domain_ttl" {
  default = 600
}

variable "zone" {
  default = "at-vie-1"
}

#
# Openshift variables
#
variable "master_count" {
  default = 3
}
variable "master_size" {
  default = "Huge"
}
variable "master_disk" {
  default = 100
}

variable "infra_count" {
  default = 2
}
variable "infra_size" {
  default = "Huge"
}
variable "infra_disk" {
  default = 200
}

variable "node_count" {
  default = 3
}
variable "node_size" {
  default = "Huge"
}
variable "node_disk" {
  default = 400
}

variable "lb_count" {
  default = 2
}
variable "lb_size" {
  default = "Huge"
}
variable "lb_disk" {
  default = 20
}

#
# Provider settings
#
provider "exoscale" {
  key = "${var.api_key}"
  secret = "${var.secret_key}"
}
provider "template" {}

#
# Modules
#
module "ssh" {
  source = "./ssh"
  public_key_file = "${var.public_key_file}"
}
module "dns" {
  source = "./dns"
  domain = "${var.domain}"
}
module "openshift" {
  source = "./openshift"
  private_key_file = "${var.private_key_file}"
  installer_ip = "${var.installer_ip}"
  zone = "${var.zone}"
  domain = "${module.dns.domain_name}"
  domain_ttl = "${var.domain_ttl}"
  master_count = "${var.master_count}"
  master_size = "${var.master_size}"
  master_disk = "${var.master_disk}"
  infra_count = "${var.infra_count}"
  infra_size="${var.infra_size}"
  infra_disk = "${var.infra_disk}"
  node_count = "${var.node_count}"
  node_size = "${var.node_size}"
  node_disk = "${var.node_disk}"
  lb_count = "${var.lb_count}"
  lb_size = "${var.lb_size}"
  lb_disk = "${var.lb_disk}"
}
