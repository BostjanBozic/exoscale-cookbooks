resource "exoscale_compute" "redis_master" {
  count = "${var.master_count}"
  template =  "Linux RedHat 7.6 64-bit"
  zone = "${var.zone}"
  size = "${var.master_size}"
  disk_size = "${var.master_disk}"
  key_pair = "exodis-key"
  security_groups = ["sg-redis"]
  display_name = "redis-master-${count.index}"
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

resource "exoscale_compute" "redis_replica" {
  count = "${var.replica_count}"
  template =  "Linux RedHat 7.6 64-bit"
  zone = "${var.zone}"
  size = "${var.replica_size}"
  disk_size = "${var.replica_disk}"
  key_pair = "exodis-key"
  security_groups = ["sg-redis"]
  display_name = "redis-replica-${count.index}"
  user_data = "${base64encode(element(data.template_file.replica.*.rendered, count.index))}"

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

resource "exoscale_compute" "redis_sentinel" {
  count = "${var.sentinel_count}"
  template =  "Linux RedHat 7.6 64-bit"
  zone = "${var.zone}"
  size = "${var.sentinel_size}"
  disk_size = "${var.sentinel_disk}"
  key_pair = "exodis-key"
  security_groups = ["sg-redis"]
  display_name = "redis-sentinel-${count.index}"
  user_data = "${base64encode(element(data.template_file.sentinel.*.rendered, count.index))}"

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
