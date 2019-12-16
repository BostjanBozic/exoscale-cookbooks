data "template_file" "master" {
  template = "${file("${path.module}/cloud-init/master-init.yaml")}"
  count = "${var.master_count}"
  vars = {
    index = "${count.index}"
    domain = "${var.domain}"
    hostname = "k8s-master-${count.index}"
    ssh_privkey = "${file("${var.private_key_file}")}"
  }
}

data "template_file" "etcd" {
  template = "${file("${path.module}/cloud-init/etcd-init.yaml")}"
  count = "${var.etcd_count}"
  vars = {
    index = "${count.index}"
    domain = "${var.domain}"
    hostname = "k8s-etcd-${count.index}"
    ssh_privkey = "${file("${var.private_key_file}")}"
  }
}

data "template_file" "node" {
  template = "${file("${path.module}/cloud-init/node-init.yaml")}"
  count = "${var.node_count}"
  vars = {
    index = "${count.index}"
    domain = "${var.domain}"
    hostname = "k8s-node-${count.index}"
    ssh_privkey = "${file("${var.private_key_file}")}"
  }
}
