* コンテナ作成
```console
$ docker-compose build
```

*データベース作成
```
$ docker-compose exec web rails db:create
```

* コンテナ起動
```console
$ docker-compose up -d #-d バックグラウンドで実行
```

* コンテナを停止
```console
$ docker-compose down
```
