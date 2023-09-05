# CloudWatchアラーム設定（踏み台サーバ）
## CWAgentによって収集されるメトリクスは名前空間がデフォルトのメトリクスと異なるので注意

## EC2のメモリ使用率90％超過
resource "aws_cloudwatch_metric_alarm" "cloudwatch_metric_alarm_ec2_step_cpu" {
  alarm_name          = "Memory_${var.env}-ec2-step"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  
  namespace   = "CWAgent"
  metric_name = "mem_used_percent"
  period      = 300
  statistic   = "Average"
  threshold   = 90

  dimensions = {
    ImageId    = var.ec2_image_id_step
    InstanceId = var.ec2_instance_id_step
    InstanceType = var.ec2_instance_type_step
  }

  alarm_actions = [var.sns_topic_arn]
}

## EC2のディスク使用率80％超過
resource "aws_cloudwatch_metric_alarm" "cloudwatch_metric_alarm_ec2_step_disk" {
  alarm_name          = "Disk_${var.env}-ec2-step"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1

  namespace   = "CWAgent"
  metric_name = "disk_used_percent"
  period      = 300
  statistic   = "Average"
  threshold   = 80

  dimensions = {
    ImageId    = var.ec2_image_id_step
    InstanceId = var.ec2_instance_id_step
    InstanceType = var.ec2_instance_type_step
    device     = var.ec2_instance_device_step
    fstype     = var.ec2_instance_fstype_step
    path       = var.ec2_monitor_target_dic_step
  }

  alarm_actions = [var.sns_topic_arn]
}