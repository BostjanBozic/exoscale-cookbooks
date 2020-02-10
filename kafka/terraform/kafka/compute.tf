resource "exoscale_compute" "kafka_node" {
  depends_on = [exoscale_security_group.sg-kafka]
  count = "${var.node_count}"
  template = "Linux CentOS 7 64-bit"
  zone = "${var.zone}"
  size = "${var.node_size}"
  disk_size = "${var.node_disk}"
  key_pair = "exokafka-key"
  security_groups = ["sg-kafka"]
  display_name = "kafka-${count.index}"
  user_data = "${base64encode(element(data.template_file.node.*.rendered, count.index))}"

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
