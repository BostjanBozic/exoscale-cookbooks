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
# Redis variables
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
variable "replica_count" {
  default = 3
}
variable "replica_size" {
  default = "Huge"
}
variable "replica_disk" {
  default = 100
}
variable "sentinel_count" {
  default = 3
}
variable "sentinel_size" {
  default = "Medium"
}
variable "sentinel_disk" {
  default = 50
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
module "redis" {
  source = "./redis"
  private_key_file = "${var.private_key_file}"
  installer_ip = "${var.installer_ip}"
  zone = "${var.zone}"
  domain = "${var.domain}"
  domain_ttl = "${var.domain_ttl}"
  master_count = "${var.master_count}"
  master_size = "${var.master_size}"
  master_disk = "${var.master_disk}"
  replica_count = "${var.replica_count}"
  replica_size = "${var.replica_size}"
  replica_disk = "${var.replica_disk}"
  sentinel_count = "${var.sentinel_count}"
  sentinel_size ="${var.sentinel_size}"
  sentinel_disk = "${var.sentinel_disk}"
}
