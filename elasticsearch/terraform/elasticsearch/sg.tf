resource "cloudstack_security_group" "sg-elasticsearch" {
  name = "sg-elasticsearch"
}

resource "cloudstack_security_group_rule" "sg-elasticsearch-rules" {
  security_group_id = "${cloudstack_security_group.sg-elasticsearch.id}"

  rule {
    protocol = "tcp"
    ports = ["9200", "9300"]
    user_security_group_list = ["sg-elasticsearch"]
  }

  rule {
    protocol = "icmp"
    user_security_group_list = ["sg-elasticsearch"]
  }

  rule {
    protocol = "tcp"
    ports = ["22", "8080", "9200"]
    cidr_list = ["${var.installer_ip}"]
  }
}
