data "template_file" "node" {
  template = "${file("${path.module}/cloud-init/node-init.yaml")}"
  count = "${var.node_count}"

  vars = {
    domain = "${var.domain}"
    hostname = "kafka-${count.index}"
  }
}
