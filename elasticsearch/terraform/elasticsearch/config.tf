data "template_file" "master" {
  template = "${file("${path.module}/cloud-init/master-init.yaml")}"
  count = "${var.master_count}"

  vars {
    domain = "${var.domain}"
    hostname = "es-master-${count.index}"
  }
}

data "template_file" "data" {
  template = "${file("${path.module}/cloud-init/data-init.yaml")}"
  count = "${var.data_count}"

  vars {
    domain = "${var.domain}"
    hostname = "es-data-${count.index}"
  }
}

data "template_file" "ingest" {
  template = "${file("${path.module}/cloud-init/ingest-init.yaml")}"
  count = "${var.ingest_count}"

  vars {
    domain = "${var.domain}"
    hostname = "es-ingest-${count.index}"
  }
}
