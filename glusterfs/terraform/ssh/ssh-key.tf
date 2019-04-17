resource "exoscale_ssh_keypair" "exogluster-key" {
  name = "exogluster-key"
  public_key = "${file("${var.public_key_file}")}"
}
