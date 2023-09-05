# 出力設定
# VPC
output "vpc_id" {
  value = aws_vpc.vpc01.id
}

# Subnet
output "public_subnet01" {
  value = aws_subnet.public_subnet01.id
}

output "private_subnet01" {
  value = aws_subnet.private_subnet01.id
}


# セキュリティグループ
output "sg_ec2_step" {
  value = aws_security_group.sg_ec2_step.id
}

output "sg_ec2_private01" {
  value = aws_security_group.sg_ec2_private01.id
}
