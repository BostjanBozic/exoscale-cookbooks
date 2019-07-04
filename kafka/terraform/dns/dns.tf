resource "exoscale_domain" "exokafka" {
  name = "${var.domain}"
}

output "domain_name" {
  value = "${exoscale_domain.exokafka.name}"
}