resource "exoscale_compute" "okd_master" {
  depends_on = [exoscale_security_group.sg-openshift]
  count = "${var.master_count}"
  template = "Linux CentOS 7 64-bit"
  zone = "${var.zone}"
  size = "${var.master_size}"
  disk_size = "${var.master_disk}"
  key_pair = "exoshift-key"
  security_groups = ["sg-openshift"]
  display_name = "okd-master-${count.index}"
  user_data = "${base64encode(element(data.template_file.master.*.rendered, count.index))}"

  connection {
    user = "centos"
    type = "ssh"
    agent = false
    host = "${self.ip_address}"
    private_key = "${file(var.private_key_file)}"
  }

  provisioner "file" {
    content = "${file(var.private_key_file)}"
    destination = "/home/centos/.ssh/id_rsa"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 600 /home/centos/.ssh/id_rsa",
    ]
  }
}

resource "exoscale_compute" "okd_infra" {
  depends_on = [exoscale_security_group.sg-openshift]
  count = "${var.infra_count}"
  template = "Linux CentOS 7 64-bit"
  zone = "${var.zone}"
  size = "${var.infra_size}"
  disk_size = "${var.infra_disk}"
  key_pair = "exoshift-key"
  security_groups = ["sg-openshift"]
  display_name = "okd-infra-${count.index}"
  user_data = "${base64encode(element(data.template_file.infra.*.rendered, count.index))}"

  connection {
    user = "centos"
    type = "ssh"
    agent = false
    host = "${self.ip_address}"
    private_key = "${file(var.private_key_file)}"
  }

  provisioner "file" {
    content = "${file(var.private_key_file)}"
    destination = "/home/centos/.ssh/id_rsa"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 600 /home/centos/.ssh/id_rsa",
    ]
  }
}

resource "exoscale_compute" "okd_node" {
  depends_on = [exoscale_security_group.sg-openshift]
  count = "${var.node_count}"
  template = "Linux CentOS 7 64-bit"
  zone = "${var.zone}"
  size = "${var.node_size}"
  disk_size = "${var.node_disk}"
  key_pair = "exoshift-key"
  security_groups = ["sg-openshift"]
  display_name = "okd-node-${count.index}"
  user_data = "${base64encode(element(data.template_file.node.*.rendered, count.index))}"

  connection {
    user = "centos"
    type = "ssh"
    agent = false
    host = "${self.ip_address}"
    private_key = "${file(var.private_key_file)}"
  }

  provisioner "file" {
    content = "${file(var.private_key_file)}"
    destination = "/home/centos/.ssh/id_rsa"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 600 /home/centos/.ssh/id_rsa",
    ]
  }
}

resource "exoscale_compute" "okd_lb" {
  depends_on = [exoscale_security_group.sg-openshift]
  count = "${var.lb_count}"
  template = "Linux CentOS 7 64-bit"
  zone = "${var.zone}"
  size = "${var.lb_size}"
  disk_size = "${var.lb_disk}"
  key_pair = "exoshift-key"
  security_groups = ["sg-openshift"]
  display_name = "okd-lb-${count.index}"
  user_data = "${base64encode(element(data.template_file.lb.*.rendered, count.index))}"

  connection {
    user = "centos"
    type = "ssh"
    agent = false
    host = "${self.ip_address}"
    private_key = "${file(var.private_key_file)}"
  }

  provisioner "file" {
    content = "${file(var.private_key_file)}"
    destination = "/home/centos/.ssh/id_rsa"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 600 /home/centos/.ssh/id_rsa",
    ]
  }
}
