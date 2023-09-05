# 踏み台サーバのIPアドレスの出力設定
output "ec2_step_public_ip" {
  value = module.ec2.ec2_step_public_ip
}