resource "exoscale_security_group" "sg-kafka" {
  name = "sg-kafka"
}

resource "exoscale_security_group_rules" "sg-kafka-rules" {
  security_group = "${exoscale_security_group.sg-kafka.name}"

  ingress {
    protocol = "TCP"
    ports = ["2181", "2888", "3888", "8083", "9091", "9092"]
    user_security_group_list = ["sg-kafka"]
  }

  ingress {
    protocol = "TCP"
    ports = ["22"]
    cidr_list = ["${var.installer_ip}"]
  }
}
