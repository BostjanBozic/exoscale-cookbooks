resource "exoscale_domain" "exoshift" {
  name = "${var.domain}"
}

output "domain_name" {
  value = "${exoscale_domain.exoshift.name}"
}
