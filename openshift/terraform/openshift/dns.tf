resource "exoscale_domain_record" "exoshift_master_record" {
  count = "${var.master_count}"
  domain = "${var.domain}"
  name = "${element(exoscale_compute.okd_master.*.name, count.index)}"
  record_type = "A"
  content = "${element(exoscale_compute.okd_master.*.ip_address, count.index)}"
  ttl = "${var.domain_ttl}"
}

resource "exoscale_domain_record" "exoshift_infra_record" {
  count = "${var.infra_count}"
  domain = "${var.domain}"
  name = "${element(exoscale_compute.okd_infra.*.name, count.index)}"
  record_type  = "A"
  content = "${element(exoscale_compute.okd_infra.*.ip_address, count.index)}"
  ttl = "${var.domain_ttl}"
}

resource "exoscale_domain_record" "exoshift_upstream_record" {
  count = "${var.infra_count}"
  domain = "${var.domain}"
  name = "*.upstream-okd"
  record_type = "A"
  content = "${element(exoscale_compute.okd_infra.*.ip_address, count.index)}"
  ttl = "${var.domain_ttl}"
}

resource "exoscale_domain_record" "exoshift_node_record" {
  count = "${var.node_count}"
  domain = "${var.domain}"
  name = "${element(exoscale_compute.okd_node.*.name, count.index)}"
  record_type = "A"
  content = "${element(exoscale_compute.okd_node.*.ip_address, count.index)}"
  ttl = "${var.domain_ttl}"
}

resource "exoscale_domain_record" "exoshift_lb_record" {
  count = "${var.lb_count}"
  domain = "${var.domain}"
  name = "${element(exoscale_compute.okd_lb.*.name, count.index)}"
  record_type = "A"
  content = "${element(exoscale_compute.okd_lb.*.ip_address, count.index)}"
  ttl = "${var.domain_ttl}"
}

resource "exoscale_domain_record" "exoshift_openshift_record" {
  count = "${var.lb_count}"
  domain = "${var.domain}"
  name = "openshift"
  record_type = "A"
  content = "${element(exoscale_compute.okd_lb.*.ip_address, count.index)}"
  ttl = "${var.domain_ttl}"
}
