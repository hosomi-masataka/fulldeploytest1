# 概要
AWSでAmazonLinux2023のEC2インスタンスを構築する際のTerraformテンプレート（記載例）です。構成としては下記の通りです。
```
構成情報
・VPC：１つ
・サブネット：パブリックとプライベートが１つずつ
・EC2：踏み台1台，プライベートサブネットに1台。すべてAmazonLinux2023
```

# ディレクトリ構成
```
|- [01_base]
|   |- [env]
|   |    |- [dev]
|   |        |-[ssh_private_keys] # ec2-userでSSHする際の秘密鍵のデプロイ先
|   |        |  |-ec2-user_provate_keys # 秘密鍵ファイル 
|   |        |- main.tf
|   |        |- varuables.tf
|   |        |- ssh_key.tf
|   |        |- output.tf
|   |- [modules]
|   |   |-[ec2] # EC2設定
|   |   |  |- [cloudwatch_agent_setting] 
|   |   |  |   |- cloudwatch_agent_setting_linux.json # CloudwatchAgent起動時に必要な設定ファイル
|   |   |  |- [iam] 
|   |   |  |   |- iam_policy.json # EC2に付与する個別のIAMポリシーの設定値
|   |   |  |- [shell] 
|   |   |  |   |- setup.sh # セットアップスクリプト（主にユーザ追加）
|   |   |  |- ec2_step.tf # 踏み台サーバ
|   |   |  |- ec2_private01.tf # プライベートサブネットサーバ
|   |   |  |- iam_setting.tf.tf
|   |   |  |- variables.tf
|   |   |  |- outputs.tf
|   |- [monitor] # アラート系の設定
|   |   |- variables.tf
|   |   |- cloudwatch_metric_alert_ec2_step.tf
|   |   |- cloudwatch_metric_alert_ec2_private01.tf
|   |   |- sns_setting.tf
|   |   |- outputs.tf
|   |- [network] # ネットワーク設定
|   |   |- network.tf
|   |   |- security_group_ec2.tf
|   |   |- security_group_endpoint.tf
|   |   |- vpc_endpoint.tf
|   |   |- variables.tf
|   |   |- outputs.tf
|
|- [02_additional] # 追加設定
|   |- main.tf
|   |- variables.tf
|   |- cloudwatch_alert_ec2_step.tf # EC2の追加監視設定
|   |- cloudwatch_alert_ec2_private01.tf # EC2の追加監視設定
```

# デプロイ手順
1. 01_base,02_additionalの順にリソースをデプロイする。
```
# 事前に/modules/ec2/shell/setup.shの修正を実施（ユーザ追加周り）
# envディレクトリまで移動
terraform init #初期化
terraform plan #エラーチェック
terraform apply #デプロイ実行
```
02_additionalは01_baseでデプロイしたEC2内のCWAgentがAWSにメトリクスを送信し始めないとメトリクスを参照できず、エラーになるため、目視でデプロイ対象メトリクスが生成されていることを確認してから、デプロイを実施する。

2. パブリックサブネットにあるサーバのアクセス確認及びec2-user以外（セットアップスクリプトで追加）への管理者権限の付与
```
# 作成されたEC2へec2-userでssh
sudo su
visudo #/etc/sudoersの編集
>  ※vimでエディタが立ち上がる
> 「#%wheel        ALL=(ALL)       NOPASSWD: ALL」と記載されている行の#を消す。
>　保存して終了

# ec2-userでログアウト
# 別途作成した作業用ユーザでssh
以下の内容を確認
・sudo suがパスワードレスで実行できること
・dockerコマンド，docker composeコマンドが実行きる（Permission Deniedにならない）

# 必要があればEC2-userの無効化及びユーザ削除
```

# アラート設定の説明（確認必要）
## ディスク使用率80％以上
カスタムメトリクスを使用
* 監視条件：5 分内の1データポイントのdisk_used_percent >= 80
* 名前空間：CWAgent
* ディメンション：ImageId,InstanceId,InstanceType,device,fstype,path
* 統計：平均値
* 期間：5分
## メモリ使用率90％オーバー
カスタムメトリクスを使用
* 監視条件：5 分内の1データポイントのmem_used_percent >= 90
* 名前空間：CWAgent
* ディメンション：ImageId,InstanceId,InstanceType
* 統計：平均値
* 期間：5分

## CPU使用率90％オーバー
デフォルトのメトリクスを使用
* 監視条件：5 分内の1データポイントのCPUUtilization >= 90
* 名前空間：AWS/EC2
* ディメンション：インスタンス別メトリクス
* 統計：平均値
* 期間：5分

## 応答有無（死活監視）
デフォルトのメトリクスを使用
* 監視条件：5 分内の1データポイントのStatusCheckFailed >= 1
* 名前空間：AWS/EC2
* ディメンション：インスタンス別メトリクス
* 統計：平均値
* 期間：5分
