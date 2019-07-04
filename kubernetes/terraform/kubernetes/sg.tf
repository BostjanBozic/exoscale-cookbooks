resource "exoscale_security_group" "sg-k8s" {
  name = "sg-k8s"
}

resource "exoscale_security_group_rules" "sg-k8s-rules" {
  security_group = "${exoscale_security_group.sg-k8s.name}"

  ingress {
    protocol = "TCP"
    ports = ["1-65535"]
    user_security_group_list = ["sg-k8s"]
  }

  ingress {
    protocol = "UDP"
    ports = ["1-65535"]
    user_security_group_list = ["sg-k8s"]
  }

  ingress {
    protocol = "TCP"
    ports = ["22", "80", "443", "6443", "30000-33000"]
    cidr_list = ["${var.installer_ip}"]
  }
}