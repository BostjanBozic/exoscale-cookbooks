resource "exoscale_domain_record" "exolastic_master_record" {
  count = "${var.master_count}"
  domain = "${var.domain}"
  name = "${element(exoscale_compute.es_master.*.name, count.index)}"
  record_type = "A"
  content = "${element(exoscale_compute.es_master.*.ip_address, count.index)}"
  ttl = "${var.domain_ttl}"
}

resource "exoscale_domain_record" "exolastic_upstream_master_record" {
  count = "${var.master_count}"
  domain = "${var.domain}"
  name = "upstream-master-es"
  record_type = "A"
  content = "${element(exoscale_compute.es_master.*.ip_address, count.index)}"
  ttl = "${var.domain_ttl}"
}

resource "exoscale_domain_record" "exolastic_data_record" {
  count = "${var.data_count}"
  domain = "${var.domain}"
  name = "${element(exoscale_compute.es_data.*.name, count.index)}"
  record_type = "A"
  content = "${element(exoscale_compute.es_data.*.ip_address, count.index)}"
  ttl = "${var.domain_ttl}"
}

resource "exoscale_domain_record" "exolastic_ingest_record" {
  count = "${var.ingest_count}"
  domain = "${var.domain}"
  name = "${element(exoscale_compute.es_ingest.*.name, count.index)}"
  record_type = "A"
  content = "${element(exoscale_compute.es_ingest.*.ip_address, count.index)}"
  ttl = "${var.domain_ttl}"
}
