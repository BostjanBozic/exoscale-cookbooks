resource "exoscale_security_group" "sg-openshift" {
  name = "sg-openshift"
}

resource "exoscale_security_group_rules" "sg-openshift-rules" {
  security_group = "${exoscale_security_group.sg-openshift.name}"

  ingress {
    protocol = "TCP"
    ports = ["1-65535"]
    user_security_group_list = ["sg-openshift"]
  }

  ingress {
    protocol = "UDP"
    ports = ["1-65535"]
    user_security_group_list = ["sg-openshift"]
  }

  ingress {
    protocol = "TCP"
    ports = ["22", "80", "443", "6443", "8443", "30000-33000"]
    cidr_list = ["${var.installer_ip}"]
  }
}

