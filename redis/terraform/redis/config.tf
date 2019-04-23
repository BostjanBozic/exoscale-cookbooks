data "template_file" "master" {
  template = "${file("${path.module}/cloud-init/master-init.yaml")}"
  count = "${var.master_count}"

  vars {
    domain = "${var.domain}"
    hostname = "redis-master-${count.index}"
  }
}

data "template_file" "slave" {
  template = "${file("${path.module}/cloud-init/slave-init.yaml")}"
  count = "${var.slave_count}"

  vars {
    domain = "${var.domain}"
    hostname = "redis-slave-${count.index}"
  }
}

data "template_file" "sentinel" {
  template = "${file("${path.module}/cloud-init/sentinel-init.yaml")}"
  count = "${var.sentinel_count}"

  vars {
    domain = "${var.domain}"
    hostname = "redis-sentinel-${count.index}"
  }
}
