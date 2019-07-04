resource "exoscale_domain" "exokube" {
  name = "${var.domain}"
}

output "domain_name" {
  value = "${exoscale_domain.exokube.name}"
}
