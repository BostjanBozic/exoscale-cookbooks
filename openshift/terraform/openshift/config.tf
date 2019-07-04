data "template_file" "master" {
  template = "${file("${path.module}/cloud-init/master-init.yaml")}"
  count = "${var.master_count}"

  vars = {
    index = "${count.index}"
    domain = "${var.domain}"
    hostname = "okd-master-${count.index}"
    ssh_privkey = "${file(var.private_key_file)}"
  }
}

data "template_file" "infra" {
  template = "${file("${path.module}/cloud-init/infra-init.yaml")}"
  count = "${var.infra_count}"

  vars = {
    index = "${count.index}"
    domain = "${var.domain}"
    hostname = "okd-infra-${count.index}"
    ssh_privkey = "${file(var.private_key_file)}"
  }
}

data "template_file" "node" {
  template = "${file("${path.module}/cloud-init/node-init.yaml")}"
  count = "${var.node_count}"

  vars = {
    index = "${count.index}"
    domain = "${var.domain}"
    hostname = "okd-node-${count.index}"
    ssh_privkey = "${file(var.private_key_file)}"
  }
}

data "template_file" "lb" {
  template = "${file("${path.module}/cloud-init/lb-init.yaml")}"
  count = "${var.lb_count}"

  vars = {
    index = "${count.index}"
    domain = "${var.domain}"
    hostname = "okd-lb-${count.index}"
    ssh_privkey = "${file(var.private_key_file)}"
  }
}
