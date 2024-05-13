## 概要
ECSを利用したサービスのdev環境は、コストカットのため夜間に停止した方が良い。

19:30にタスク数を0にし、9:30にタスク数を1にする。

## EventBridgeの設定

まずLambda関数を作成し、ARNを置き換える。

```
cd tf
```

terraformを初期化
```
terraform init
```

操作の詳細を表示
```
terraform plan
```

問題がなければ、実行し環境を構築
```
terraform apply
```