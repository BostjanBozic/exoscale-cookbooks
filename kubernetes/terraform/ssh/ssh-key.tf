resource "exoscale_ssh_keypair" "exokube-key" {
  name = "exokube-key"
  public_key = "${file(var.public_key_file)}"
}
