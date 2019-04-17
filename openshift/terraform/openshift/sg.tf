resource "cloudstack_security_group" "sg-openshift" {
  name = "sg-openshift"
}

resource "cloudstack_security_group_rule" "sg-openshift-rules" {
  security_group_id ="${cloudstack_security_group.sg-openshift.id}"

  rule {
    protocol = "tcp"
    ports = ["1-65535"]
    user_security_group_list = ["sg-openshift"]
  }

  rule {
    protocol = "udp"
    ports = ["1-65535"]
    user_security_group_list = ["sg-openshift"]
  }

  rule {
    protocol = "tcp"
    ports = ["22", "80", "443", "6443", "8443", "30000-33000"]
    cidr_list = ["${var.installer_ip}"]
  }
}

