resource "exoscale_domain_record" "exodis_master_record" {
  count = "${var.master_count}"
  domain = "${var.domain}"
  name = "${element(exoscale_compute.redis_master.*.name, count.index)}"
  record_type = "A"
  content = "${element(exoscale_compute.redis_master.*.ip_address, count.index)}"
  ttl = "${var.domain_ttl}"
}

resource "exoscale_domain_record" "exodis_upstream_master_record" {
  count = "${var.master_count}"
  domain = "${var.domain}"
  name = "upstream-master-redis"
  record_type = "A"
  content = "${element(exoscale_compute.redis_master.*.ip_address, count.index)}"
  ttl = "${var.domain_ttl}"
}

resource "exoscale_domain_record" "exodis_replica_record" {
  count = "${var.replica_count}"
  domain = "${var.domain}"
  name = "${element(exoscale_compute.redis_replica.*.name, count.index)}"
  record_type = "A"
  content = "${element(exoscale_compute.redis_replica.*.ip_address, count.index)}"
  ttl = "${var.domain_ttl}"
}

resource "exoscale_domain_record" "exodis_sentinel_record" {
  count = "${var.sentinel_count}"
  domain = "${var.domain}"
  name = "${element(exoscale_compute.redis_sentinel.*.name, count.index)}"
  record_type = "A"
  content = "${element(exoscale_compute.redis_sentinel.*.ip_address, count.index)}"
  ttl = "${var.domain_ttl}"
}
