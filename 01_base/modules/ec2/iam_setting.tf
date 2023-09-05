#https://docs.aws.amazon.com/ja_jp/AmazonCloudWatch/latest/monitoring/create-iam-roles-for-cloudwatch-agent-commandline.html
# IAM Policy for Cloudwatch Agent  
resource "aws_iam_policy" "iam_policy_cloudwatch_agent" {
  name = "${var.env}-cloudwatch-agent-policy"
  path = "/"

  policy = templatefile("./../../modules/ec2/iam_setting/iam_policy.json", {})
}

# IAM Role
resource "aws_iam_role" "iam_role_cloudwatch_agent" {
  name                = "${var.env}-cloudwatch-agent-role"
  managed_policy_arns = ["arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy",aws_iam_policy.iam_policy_cloudwatch_agent.arn]
  assume_role_policy  = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

# IAM Profile
resource "aws_iam_instance_profile" "iam_instance_profile_ec2" {
  name = "${var.env}-iam-instance-profile-ec2"
  role = aws_iam_role.iam_role_cloudwatch_agent.name
}