resource "exoscale_security_group" "sg-k8s" {
  name = "sg-k8s"
}

resource "exoscale_security_group_rules" "sg-k8s-rules" {
  security_group = "${exoscale_security_group.sg-k8s.name}"

  ingress {
    protocol = "TCP"
    ports = ["2379-2380", "6443", "10250-10252", "30000-32767", "6783"]
    user_security_group_list = ["sg-k8s"]
  }

  ingress {
    protocol = "UDP"
    ports = ["8285", "8472", "6781-6784"]
    user_security_group_list = ["sg-k8s"]
  }

  ingress {
    protocol = "TCP"
    ports = ["22", "80", "443", "6443", "30000-33000"]
    cidr_list = ["${var.installer_ip}"]
  }
}