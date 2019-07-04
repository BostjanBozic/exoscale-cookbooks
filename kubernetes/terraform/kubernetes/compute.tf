resource "exoscale_compute" "k8s_master" {
  depends_on = ["exoscale_security_group.sg-k8s"]
  count = "${var.master_count}"
  template = "Linux CoreOS 1967.5.0 64-bit"
  zone = "${var.zone}"
  size = "${var.master_size}"
  disk_size = "${var.master_disk}"
  key_pair = "exokube-key"
  security_groups = ["sg-k8s"]
  display_name = "k8s-master-${count.index}"
  user_data = "${base64encode(element(data.template_file.master.*.rendered, count.index))}"

  connection {
    user ="core"
    type = "ssh"
    agent = false
    host = "${self.ip_address}"
    private_key = "${file(var.private_key_file)}"
  }

  provisioner "file" {
    content = "${file(var.private_key_file)}"
    destination = "/home/core/.ssh/id_rsa"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 600 /home/core/.ssh/id_rsa",
    ]
  }
}

resource "exoscale_compute" "k8s_etcd" {
  depends_on = ["exoscale_security_group.sg-k8s"]
  count = "${var.etcd_count}"
  template = "Linux CoreOS 1967.5.0 64-bit"
  zone = "${var.zone}"
  size = "${var.etcd_size}"
  disk_size = "${var.etcd_disk}"
  key_pair = "exokube-key"
  security_groups = ["sg-k8s"]
  display_name = "k8s-etcd-${count.index}"
  user_data = "${base64encode(element(data.template_file.etcd.*.rendered, count.index))}"

  connection {
    user = "core"
    type = "ssh"
    agent = false
    host = "${self.ip_address}"
    private_key = "${file(var.private_key_file)}"
  }

  provisioner "file" {
    content = "${file(var.private_key_file)}"
    destination = "/home/core/.ssh/id_rsa"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 600 /home/core/.ssh/id_rsa",
    ]
  }
}

resource "exoscale_compute" "k8s_node" {
  depends_on = ["exoscale_security_group.sg-k8s"]
  count = "${var.node_count}"
  template = "Linux CoreOS 1967.5.0 64-bit"
  zone = "${var.zone}"
  size = "${var.node_size}"
  disk_size = "${var.node_disk}"
  key_pair = "exokube-key"
  security_groups = ["sg-k8s"]
  display_name = "k8s-node-${count.index}"
  user_data = "${base64encode(element(data.template_file.node.*.rendered, count.index))}"

  connection {
    user = "core"
    type = "ssh"
    agent = false
    host = "${self.ip_address}"
    private_key = "${file(var.private_key_file)}"
  }

  provisioner "file" {
    content = "${file(var.private_key_file)}"
    destination = "/home/core/.ssh/id_rsa"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 600 /home/core/.ssh/id_rsa",
    ]
  }
}
