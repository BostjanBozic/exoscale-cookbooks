resource "exoscale_domain_record" "exokube_master_record" {
  count = "${var.master_count}"
  domain = "${var.domain}"
  name = "${element(exoscale_compute.k8s_master.*.name, count.index)}"
  record_type = "A"
  content = "${element(exoscale_compute.k8s_master.*.ip_address, count.index)}"
  ttl = "${var.domain_ttl}"
}

resource "exoscale_domain_record" "exokube_etcd_record" {
  count = "${var.etcd_count}"
  domain = "${var.domain}"
  name = "${element(exoscale_compute.k8s_etcd.*.name, count.index)}"
  record_type = "A"
  content = "${element(exoscale_compute.k8s_etcd.*.ip_address, count.index)}"
  ttl = "${var.domain_ttl}"
}

resource "exoscale_domain_record" "exokube_node_record" {
  count = "${var.node_count}"
  domain = "${var.domain}"
  name = "${element(exoscale_compute.k8s_node.*.name, count.index)}"
  record_type = "A"
  content = "${element(exoscale_compute.k8s_node.*.ip_address, count.index)}"
  ttl = "${var.domain_ttl}"
}

resource "exoscale_domain_record" "exokube_node_sd_record" {
  count = "${var.node_count}"
  domain = "${var.domain}"
  name = "upstream-sd"
  record_type = "A"
  content = "${element(exoscale_compute.k8s_node.*.ip_address, count.index)}"
  ttl = "${var.domain_ttl}"
}
