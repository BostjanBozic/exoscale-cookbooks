resource "cloudstack_security_group" "sg-redis" {
  name = "sg-redis"
}

resource "cloudstack_security_group_rule" "sg-redis-rules" {
  security_group_id = "${cloudstack_security_group.sg-redis.id}"

  rule {
    protocol = "tcp"
    ports = ["6379", "16379"]
    user_security_group_list = ["sg-redis"]
  }

  rule {
    protocol = "tcp"
    ports = ["22", "6379"]
    cidr_list = ["${var.installer_ip}"]
  }
}
