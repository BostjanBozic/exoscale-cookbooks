resource "exoscale_security_group" "sg-glusterfs" {
  name = "sg-glusterfs"
}

resource "exoscale_security_group_rules" "sg-glusterfs-rules" {
  security_group = "${exoscale_security_group.sg-glusterfs.name}"

  ingress {
    protocol = "TCP"
    ports = ["111", "24007-24008", "38465-38467", "49152-49664"]
    user_security_group_list = ["sg-glusterfs"]
  }

  ingress {
    protocol = "UDP"
    ports = ["111"]
    user_security_group_list = ["sg-glusterfs"]
  }

  ingress {
    protocol = "TCP"
    ports = ["22"]
    cidr_list = ["${var.installer_ip}"]
  }
}
