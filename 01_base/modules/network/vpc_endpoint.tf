# VPCエンドポイント（CloudWatchAgentの通信で必要）
resource "aws_vpc_endpoint" "vpc_endpoint_cloudwatch" {
  vpc_id             = aws_vpc.vpc01.id
  service_name       = "com.amazonaws.ap-northeast-1.monitoring"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = [aws_subnet.private_subnet01.id]
  security_group_ids = ["${aws_security_group.sg_vpc_endpoint.id}"]

  tags = {
    Name = "${var.env}-vpc-endpoint-cloudwatch"
  }
}


resource "aws_vpc_endpoint" "vpc_endpoint_cloudwatchlogs" {
  vpc_id             = aws_vpc.vpc01.id
  service_name       = "com.amazonaws.ap-northeast-1.logs"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = [aws_subnet.private_subnet01.id]
  security_group_ids = ["${aws_security_group.sg_vpc_endpoint.id}"]

  tags = {
    Name = "${var.env}-vpc-endpoint-cloudwatch-logs"
  }
}

resource "aws_vpc_endpoint" "vpc_endpoint_ec2" {
  vpc_id             = aws_vpc.vpc01.id
  service_name       = "com.amazonaws.ap-northeast-1.ec2"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = [aws_subnet.private_subnet01.id]
  security_group_ids = ["${aws_security_group.sg_vpc_endpoint.id}"]

  tags = {
    Name = "${var.env}-vpc-endpoint-ec2"
  }
}