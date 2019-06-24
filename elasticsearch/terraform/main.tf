variable "api_key" {}
variable "secret_key" {}
variable "private_key_file" {}
variable "public_key_file" {}
variable "installer_ip" {}

variable "domain" {}
variable "domain_ttl" {
  default =600
}

variable "zone" {
  default = "at-vie-1"
}

#
# Elasticsearch variables
#
variable "master_count" {
  default = 2
}
variable "master_size" {
  default = "Medium"
}
variable "master_disk" {
  default = 100
}

variable "data_count" {
  default = 4
}
variable "data_size" {
  default = "Huge"
}
variable "data_disk" {
  default = 800
}

variable "ingest_count" {
  default = 1
}
variable "ingest_size" {
  default = "Huge"
}
variable "ingest_disk" {
  default = 400
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
module "elasticsearch" {
  source = "./elasticsearch"
  private_key_file = "${var.private_key_file}"
  installer_ip = "${var.installer_ip}"
  zone = "${var.zone}"
  domain = "${var.domain}"
  domain_ttl = "${var.domain_ttl}"
  master_count = "${var.master_count}"
  master_size = "${var.master_size}"
  master_disk = "${var.master_disk}"
  data_count = "${var.data_count}"
  data_size = "${var.data_size}"
  data_disk = "${var.data_disk}"
  ingest_count = "${var.ingest_count}"
  ingest_size = "${var.ingest_size}"
  ingest_disk = "${var.ingest_disk}"
}
