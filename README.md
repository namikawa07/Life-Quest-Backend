http://localhost:3000/


# Task Quest
## Docker Start

### dockerのnetworkを作成
```
docker network create taskQuest
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
