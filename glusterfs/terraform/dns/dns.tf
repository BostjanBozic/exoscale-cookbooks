resource "exoscale_domain" "exogluster" {
  name = "${var.domain}"
}

output "domain_name" {
  value = "${exoscale_domain.exogluster.name}"
}
