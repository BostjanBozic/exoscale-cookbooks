resource "exoscale_ssh_keypair" "exolastic-key" {
  name = "exolastic-key"
  public_key = "${file("${var.public_key_file}")}"
}
