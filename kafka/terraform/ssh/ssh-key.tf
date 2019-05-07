resource "exoscale_ssh_keypair" "exokafka-key" {
  name = "exokafka-key"
  public_key = "${file("${var.public_key_file}")}"
}
