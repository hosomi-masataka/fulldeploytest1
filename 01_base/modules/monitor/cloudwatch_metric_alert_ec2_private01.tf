# CloudWatchアラーム設定（踏み台サーバ）
## EC2のCPU使用率90％超過
resource "aws_cloudwatch_metric_alarm" "cloudwatch_metric_alarm_ec2_private01_cpu" {
  alarm_name          = "CPU_${var.env}-ec2-private01"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1

  namespace   = "AWS/EC2"
  metric_name = "CPUUtilization"
  period      = 300
  statistic   = "Average"
  threshold   = 90

  dimensions = {
    InstanceId = var.ec2_instance_id_private01
  }

  alarm_actions = [aws_sns_topic.sns_topic.arn]
}

## EC2の死活監視
resource "aws_cloudwatch_metric_alarm" "cloudwatch_metric_alarm_ec2_private01_status" {
  alarm_name          = "InstanceCheck_${var.env}-ec2-private01"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1

  namespace   = "AWS/EC2"
  metric_name = "StatusCheckFailed"
  period      = 300
  statistic   = "Average"
  threshold   = 1

  dimensions = {
    InstanceId = var.ec2_instance_id_private01
  }

  alarm_actions = [aws_sns_topic.sns_topic.arn]
}