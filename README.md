### 概要
Atocoderに掲載されている問題から、指定したアルゴリズムを扱う問題をレスポンスしてくれる。
# URL
```
https://atcoder-app.onrender.com
```

## 基本的なDockerのコマンド

* コンテナ作成
```console
$ docker-compose build
```

* コンテナ起動
```console
$ docker-compose up -d #-d バックグラウンドで実行
```

*　データベース作成
```
$ docker-compose exec web rails db:create
```

* コンテナを停止
```console
$ docker-compose down
```
## 環境構築後の開発の仕方

ファイルの編集などは基本ローカル環境で行います。
しかしrails g や rails db:migrateなどの railsコマンド はコンテナ内で実行します。
以下のコマンドでRailsのコンテナに入ります。

```
$ docker-compose exec web bash
```

これまでのローカル環境での開発で、ターミナルで実行していたコマンドは全てこのコンテナ内で行います。( gitコマンドはローカル環境で行います )
コンテナを抜けるには、以下のコマンドを実行してください。( もしくはcontrol + d )

```
$ exit
```
## ログの表示

```
$ tail -f log/development.log
```


<small>&copy;</small>MizutaLabo
