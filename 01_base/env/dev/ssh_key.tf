# VM用のSSHキー設定
resource "tls_private_key" "ssh_private_key" {
  algorithm = "RSA"
  rsa_bits = 2048
}

resource "aws_key_pair" "ssh_keypair" {
  key_name   = "${var.env}-ssh-key"
  public_key = tls_private_key.ssh_private_key.public_key_openssh
}

# 秘密鍵をローカルファイルへ出力
resource "local_file" "ec2-user_private_key_file" {
  content  = tls_private_key.ssh_private_key.private_key_pem
  filename = "./ssh_private_keys/ec2-user_private_key_amazonlinux"
}