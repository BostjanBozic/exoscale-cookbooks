resource "cloudstack_security_group" "sg-kafka" {
  name = "sg-kafka"
}

resource "cloudstack_security_group_rule" "sg-kafka-rules" {
  security_group_id = "${cloudstack_security_group.sg-kafka.id}"

  rule {
    protocol = "tcp"
    ports = ["2181", "2888", "3888", "9091", "9092"]
    user_security_group_list = ["sg-kafka"]
  }

  rule {
    protocol = "tcp"
    ports = ["22"]
    cidr_list = ["${var.installer_ip}"]
  }
}
