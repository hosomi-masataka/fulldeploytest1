# セキュリティグループ設定（EC2用）
## EC2(踏み台Linux)サーバ用
resource "aws_security_group" "sg_ec2_step" {
  name   = "${var.env}-sg-ec2-step"
  vpc_id = aws_vpc.vpc01.id
  ### インバウンドルール
  #### パナIPからのSSH
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = [var.ssh_access_cider ]
  }

  ### アウトバウンドルール
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.env}-sg-ec2-step"
  }
}


## EC2(プライベートLinux)サーバ用
resource "aws_security_group" "sg_ec2_private01" {
  name   = "${var.env}-sg-ec2-private01"
  vpc_id = aws_vpc.vpc01.id
  ### インバウンドルール
  #### 踏み台からのSSH
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_ec2_step.id]
  }

  ### アウトバウンドルール
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.env}-sg-ec2-private01"
  }
}
