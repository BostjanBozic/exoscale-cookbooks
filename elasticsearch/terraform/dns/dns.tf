resource "exoscale_domain" "exolastic" {
  name = "${var.domain}"
}

output "domain_name" {
  value = "${exoscale_domain.exolastic.name}"
}
