/* -------------- リソース名設定 --------------*/
## 環境名（開発・ステージング・本番）を指定。作成されるリソース名の先頭にこの変数に入れた文字がくるように設定
variable "env" {
  default = "test-ec2-env-amazonlinux"
}
## 小文字しかインスタンス名に使えないリソース用
variable "env_lowercase" {
  default = "test-ec2-env-amazonlinux"
}

/* -------------- 基本設定 --------------*/
## 仕様するリージョン
variable "region" {
  default = "ap-northeast-1"
}

/* -------------- 監視対象設定 --------------*/
# 以下の設定は実際にCloudwatch上に生成されたメトリクスデータを参照しながら記入してください。
## 踏み台サーバ
### AMI ID
variable "ec2_image_id_step" {
    default = "ami-08c84d37db8aafe00"
}

### インスタンスID
variable "ec2_instance_id_step" {
  default = "i-0bd176be384e30d06"
}
### 監視対象ディレクトリパス（ディスク容量監視で使用）
variable "ec2_monitor_target_dic_step" {
    default = "/"
}

### インスタンスタイプ
variable "ec2_instance_type_step" {
    default = "t3.micro"
}
### ディスクデバイス名
variable "ec2_instance_device_step" {
    default = "nvme0n1p1"
}
### ファイルシステムタイプ
variable "ec2_instance_fstype_step" {
    default = "xfs"
}

## プライベートサブネットサーバ
### AMI ID
variable "ec2_image_id_private01" {
    default = "ami-08c84d37db8aafe00"
}

### インスタンスID
variable "ec2_instance_id_private01" {
  default = "i-03f61ef6bcd52cfab"
}

### 監視対象ディレクトリパス（ディスク容量監視で使用）
variable "ec2_monitor_target_dic_private01" {
    default = "/"
}

### インスタンスタイプ
variable "ec2_instance_type_private01" {
    default = "t3.micro"
}
### ディスクデバイス名
variable "ec2_instance_device_private01" {
    default = "nvme0n1p1"
}
### ファイルシステムタイプ
variable "ec2_instance_fstype_private01" {
    default = "xfs"
}

## アラート通知先SNSトピック
variable "sns_topic_arn" {
  default = "arn:aws:sns:ap-northeast-1:501236257361:test-ec2-env-amazonlinux-sns-topic"
}