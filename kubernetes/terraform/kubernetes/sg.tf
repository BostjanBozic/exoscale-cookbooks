resource "cloudstack_security_group" "sg-k8s" {
  name = "sg-k8s"
}

resource "cloudstack_security_group_rule" "sg-k8s-rules" {
  security_group_id = "${cloudstack_security_group.sg-k8s.id}"

  rule {
    protocol = "tcp"
    ports = ["1-65535"]
    user_security_group_list = ["sg-k8s"]
  }

  rule {
    protocol = "udp"
    ports = ["1-65535"]
    user_security_group_list = ["sg-k8s"]
  }

  rule {
    protocol = "tcp"
    ports = ["22", "80", "443", "6443", "30000-33000"]
    cidr_list = ["${var.installer_ip}"]
  }
}