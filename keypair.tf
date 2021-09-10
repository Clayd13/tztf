resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

module "key_pair" {
  source  = "terraform-aws-modules/key-pair/aws"
  version = "1.0.0"

  key_name   = var.generated_key_name
  public_key = tls_private_key.this.public_key_openssh

}


# Generate "terraform-key-pair.pem" in current directory
resource "null_resource" "gen-pair-step1" {
  provisioner "local-exec" {
    command = "echo '${tls_private_key.this.private_key_pem}' > ./'${var.generated_key_name}'.pem"
  }
}

resource "null_resource" "gen-pair-step2" {
  provisioner "local-exec" {
    command = "chmod 400 ./'${var.generated_key_name}'.pem"
  }
}
