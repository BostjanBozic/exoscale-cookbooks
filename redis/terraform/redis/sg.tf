resource "exoscale_security_group" "sg-redis" {
  name = "sg-redis"
}

resource "exoscale_security_group_rules" "sg-redis-rules" {
  security_group = "${exoscale_security_group.sg-redis.name}"

  ingress {
    protocol = "TCP"
    ports = ["6379", "16379"]
    user_security_group_list = ["sg-redis"]
  }

  ingress {
    protocol = "TCP"
    ports = ["22", "6379"]
    cidr_list = ["${var.installer_ip}"]
  }
}
