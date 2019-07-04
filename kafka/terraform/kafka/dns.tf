resource "exoscale_domain_record" "exokafka_node_record" {
  count = "${var.node_count}"
  domain = "${var.domain}"
  name = "${element(exoscale_compute.kafka_node.*.name, count.index)}"
  record_type = "A"
  content = "${element(exoscale_compute.kafka_node.*.ip_address, count.index)}"
  ttl = "${var.domain_ttl}"
}

resource "exoscale_domain_record" "exokafka_upstream_record" {
  count = "${var.node_count}"
  domain = "${var.domain}"
  name = "upstream-kafka"
  record_type = "A"
  content = "${element(exoscale_compute.kafka_node.*.ip_address, count.index)}"
  ttl = "${var.domain_ttl}"
}
