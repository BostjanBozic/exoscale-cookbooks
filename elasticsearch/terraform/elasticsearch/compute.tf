resource "exoscale_compute" "es_master" {
  depends_on = ["exoscale_security_group.sg-elasticsearch"]
  count = "${var.master_count}"
  template = "Linux RedHat 7.6 64-bit"
  zone = "${var.zone}"
  size = "${var.master_size}"
  disk_size = "${var.master_disk}"
  key_pair = "exolastic-key"
  security_groups = ["sg-elasticsearch"]
  display_name = "es-master-${count.index}"
  user_data = "${base64encode(element(data.template_file.master.*.rendered, count.index))}"

  connection {
    user = "cloud-user"
    type = "ssh"
    agent = false
    host = "${self.ip_address}"
    private_key = "${file(var.private_key_file)}"
  }

  provisioner "file" {
    content = "${file(var.private_key_file)}"
    destination = "/home/cloud-user/.ssh/id_rsa"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 600 /home/cloud-user/.ssh/id_rsa",
    ]
  }
}

resource "exoscale_compute" "es_data" {
  depends_on = ["exoscale_security_group.sg-elasticsearch"]
  count = "${var.data_count}"
  template = "Linux RedHat 7.6 64-bit"
  zone = "${var.zone}"
  size = "${var.data_size}"
  disk_size = "${var.data_disk}"
  key_pair = "exolastic-key"
  security_groups = ["sg-elasticsearch"]
  display_name = "es-data-${count.index}"
  user_data = "${base64encode(element(data.template_file.data.*.rendered, count.index))}"

  connection {
    user = "cloud-user"
    type = "ssh"
    agent = false
    host = "${self.ip_address}"
    private_key = "${file(var.private_key_file)}"
  }

  provisioner "file" {
    content = "${file(var.private_key_file)}"
    destination = "/home/cloud-user/.ssh/id_rsa"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 600 /home/cloud-user/.ssh/id_rsa",
    ]
  }
}

resource "exoscale_compute" "es_ingest" {
  depends_on = ["exoscale_security_group.sg-elasticsearch"]
  count = "${var.ingest_count}"
  template = "Linux RedHat 7.6 64-bit"
  zone = "${var.zone}"
  size = "${var.ingest_size}"
  disk_size = "${var.ingest_disk}"
  key_pair = "exolastic-key"
  security_groups = ["sg-elasticsearch"]
  display_name = "es-ingest-${count.index}"
  user_data = "${base64encode(element(data.template_file.ingest.*.rendered, count.index))}"

  connection {
    user = "cloud-user"
    type = "ssh"
    agent = false
    host = "${self.ip_address}"
    private_key = "${file(var.private_key_file)}"
  }

  provisioner "file" {
    content = "${file(var.private_key_file)}"
    destination = "/home/cloud-user/.ssh/id_rsa"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 600 /home/cloud-user/.ssh/id_rsa",
    ]
  }
}
