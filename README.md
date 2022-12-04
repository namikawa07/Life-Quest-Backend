http://localhost:3000/


# Life Quest
## Docker Start

### dockerのnetworkを作成
```
docker network create life-quest
```

### dockerを立ち上げる
```
$ docker-compose build
$ docker-compose up
```

### docker-compose up できない時
```
rm tmp/pids/server.pid
```

### bundle install bundle updateするとき
wait-for-it.shが邪魔してbundle実行できないので一旦コメントアウトしてからbundleしてコメントアウト外す

docker-compose.yml
```
services:
  api:
    # ここをコメントアウト
    # entrypoint: ./wait-for-it.sh db:3306
```

# Redis
```
docker-compose exec redis /bin/bash
redis-cli
```

### key一覧表示
```
keys *
```


# Sidekiq

### Jobを作成する
```
docker-compose exec web rails g sidekiq:job Hello
```

### 使用する
#### perform_asyncの他にもあると思う
#### 通知形はよく使う、他どこで使ってるか確認
```
HelloJob.perform_async or HelloJob.perform_laterなど
```


# postgesql
対話モード
```
mysql -u root -p　root

パスワードを入れる
```

# やることメモ
ログインがJWT認証されてないのでする。脆弱性について調べて対策する
更新するとcurrent_userが消えてしまうので消えないようにする



# コンセプト
人生をレベルアップさせよう
# サービス名
Life Quest


### cloneしたらやること
master.keyとcredentials.ymlファイルを作る
envのFIREBASE_PROJECT_IDをfirebaseのプロジェクトに対応する値にする
dockerのnetwork名を変更する
