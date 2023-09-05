# セキュリティグループ設定（VPCエンドポイント用）
resource "aws_security_group" "sg_vpc_endpoint" {
  name   = "${var.env}-sg-vpc-endpoint"
  vpc_id = aws_vpc.vpc01.id
  ### インバウンドルール
  ### 各EC2からのHTTPSアクセス
  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_ec2_step.id,aws_security_group.sg_ec2_private01.id]
  }


  ### アウトバウンドルール
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.env}-sg-vpc-endpoint"
  }
}