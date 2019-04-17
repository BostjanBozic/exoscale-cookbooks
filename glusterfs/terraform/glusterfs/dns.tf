resource "exoscale_domain_record" "exogluster_node_record" {
  count = "${var.node_count}"
  domain = "${var.domain}"
  name = "${element(exoscale_compute.gluster_node.*.name, count.index)}"
  record_type = "A"
  content = "${element(exoscale_compute.gluster_node.*.ip_address, count.index)}"
  ttl = "${var.domain_ttl}"
}

resource "exoscale_domain_record" "exogluster_upstream_record" {
  count = "${var.node_count}"
  domain = "${var.domain}"
  name = "upstream-glusterfs"
  record_type = "A"
  content = "${element(exoscale_compute.gluster_node.*.ip_address, count.index)}"
  ttl = "${var.domain_ttl}"
}
