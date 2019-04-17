data "template_file" "node" {
  template = "${file("${path.module}/cloud-init/node-init.yaml")}"
  count = "${var.node_count}"

  vars {
    domain = "${var.domain}"
    hostname = "glusterfs-${count.index}"
    gluster_version = "${var.gluster_version}"
  }
}
