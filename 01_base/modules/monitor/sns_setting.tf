# Amazon SNS 
resource "aws_sns_topic" "sns_topic" {
  name = "${var.env}-sns-topic"
}

resource "aws_sns_topic_subscription" "sns_topic_subscription01" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "email"
  endpoint  = var.sns_email01
}

resource "aws_sns_topic_subscription" "sns_topic_subscription02" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "email"
  endpoint  = var.sns_email02
}

resource "aws_sns_topic_subscription" "sns_topic_subscription32" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "email"
  endpoint  = var.sns_email03
}