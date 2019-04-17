resource "exoscale_ssh_keypair" "exoshift-key" {
  name = "exoshift-key"
  public_key = "${file("${var.public_key_file}")}"
}
