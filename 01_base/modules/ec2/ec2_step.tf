# EC2
## ネットワークインターフェース
resource "aws_network_interface" "ec2_nic_step" {
  subnet_id       = var.public_subnet01
  security_groups = [var.sg_ec2_step]
  private_ips     = [var.ec2_step_private_ip]
}

## Elastic IP
resource "aws_eip" "eip_ec2_step" {
  vpc               = true
  network_interface = aws_network_interface.ec2_nic_step.id
}




## EC2
resource "aws_instance" "ec2_step" {
  ami                  = var.ec2_step_ami_id
  instance_type        = var.ec2_step_instance_type
  key_name             = var.public_key_id
  iam_instance_profile = aws_iam_instance_profile.iam_instance_profile_ec2.name
  root_block_device {
    volume_size = var.ec2_step_volume_size
    volume_type = var.ec2_step_volume_type
  }

  network_interface {
    network_interface_id = aws_network_interface.ec2_nic_step.id
    device_index         = 0
  }

  user_data = file("./../../modules/ec2/shell/setup.sh")

  tags = {
    Name = "${var.env}-ec2-step"
  }


  ## Provisioner Setting
  ### Cloudwatch Agentのセットアップ
  #### 接続設定
  connection {
      type        = "ssh"
      user        = "ec2-user"
      host        = self.public_ip
      private_key = file(var.private_key_path)
      timeout     = "5m"
    }

  #### CloudwatchAgent設定ファイルの移送
  provisioner "file" {
    source      = "./../../modules/ec2/cloudwatch_agent_setting/cloudwatch_agent_setting_linux.json"
    destination = "/home/ec2-user/cloudwatch_agent_setting.json"
  }

  
  #### CloudwatchAegent 設定スクリプトの実行
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install amazon-cloudwatch-agent -y",
      "sudo cp /home/ec2-user/cloudwatch_agent_setting.json /opt/aws/amazon-cloudwatch-agent/bin/config.json",
      "sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json",
      "sudo rm -rf /home/ec2-user/cloudwatch_agent_setting.json"
    ]
  }
}


