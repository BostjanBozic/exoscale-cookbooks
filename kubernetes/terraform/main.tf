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
# k8s variables
#
variable "master_count" {
  default = 3
}
variable "master_size" {
  default = "Medium"
}
variable "master_disk" {
  default = 100
}


variable "etcd_count" {
  default = 3
}
variable "etcd_size" {
  default = "Medium"
}
variable "etcd_disk" {
  default = 10
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

#
# Provider settings
#
provider "exoscale" {
  token = "${var.api_key}"
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
module "kubernetes" {
  source = "./kubernetes"
  private_key_file = "${var.private_key_file}"
  installer_ip = "${var.installer_ip}"
  zone = "${var.zone}"
  domain = "${module.dns.domain_name}"
  domain_ttl = "${var.domain_ttl}"
  master_count = "${var.master_count}"
  master_size = "${var.master_size}"
  master_disk = "${var.master_disk}"
  etcd_count = "${var.etcd_count}"
  etcd_size = "${var.etcd_size}"
  etcd_disk = "${var.etcd_disk}"
  node_count = "${var.node_count}"
  node_size = "${var.node_size}"
  node_disk = "${var.node_disk}"
}
