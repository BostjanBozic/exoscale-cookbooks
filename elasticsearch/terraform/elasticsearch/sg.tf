resource "exoscale_security_group" "sg-elasticsearch" {
  name = "sg-elasticsearch"
}

resource "exoscale_security_group_rules" "sg-elasticsearch-rules" {
  security_group = "${exoscale_security_group.sg-elasticsearch.name}"

  ingress {
    protocol = "TCP"
    ports = ["9200", "9300"]
    user_security_group_list = ["sg-elasticsearch"]
  }

  ingress {
    protocol = "ICMP"
    user_security_group_list = ["sg-elasticsearch"]
  }

  ingress {
    protocol = "TCP"
    ports = ["22", "8080", "9200"]
    cidr_list = ["${var.installer_ip}"]
  }
}
