resource "cloudstack_security_group" "sg-glusterfs" {
  name = "sg-glusterfs"
}

resource "cloudstack_security_group_rule" "sg-glusterfs-rules" {
  security_group_id = "${cloudstack_security_group.sg-glusterfs.id}"

  rule {
    protocol = "tcp"
    ports = ["111", "24007-24008", "38465-38467", "49152-49664"]
    user_security_group_list = ["sg-glusterfs"]
  }

  rule {
    protocol = "udp"
    ports = ["111"]
    user_security_group_list = ["sg-glusterfs"]
  }

  rule {
    protocol = "tcp"
    ports = ["22"]
    cidr_list = ["${var.installer_ip}"]
  }
}
