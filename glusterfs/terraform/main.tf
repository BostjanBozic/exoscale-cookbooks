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
# GlusterFS settings
#
variable "node_count" {
  default = 4
}
variable "node_size" {
  default = "Extra-large"
}
variable "node_disk" {
  default = 800
}
variable "gluster_version" {
  default = 6
}


#
# Provider settings
#
provider "exoscale" {
  token = "${var.api_key}"
  secret = "${var.secret_key}"
}
provider "cloudstack" {
  api_url = "https://api.exoscale.ch/compute"
  api_key = "${var.api_key}"
  secret_key = "${var.secret_key}"
  timeout =60
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
module "glusterfs" {
  source = "./glusterfs"
  private_key_file = "${var.private_key_file}"
  installer_ip = "${var.installer_ip}"
  zone = "${var.zone}"
  domain = "${var.domain}"
  domain_ttl = "${var.domain_ttl}"
  node_count = "${var.node_count}"
  node_size = "${var.node_size}"
  node_disk = "${var.node_disk}"
  gluster_version = "${var.gluster_version}"
}
