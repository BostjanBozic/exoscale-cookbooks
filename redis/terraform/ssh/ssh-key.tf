resource "exoscale_ssh_keypair" "exodis-key" {
  name = "exodis-key"
  public_key = "${file("${var.public_key_file}")}"
}
