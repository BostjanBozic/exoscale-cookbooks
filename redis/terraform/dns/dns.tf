resource "exoscale_domain" "exodis" {
  name = "${var.domain}"
}

output "domain_name" {
  value = "${exoscale_domain.exodis.name}"
}
