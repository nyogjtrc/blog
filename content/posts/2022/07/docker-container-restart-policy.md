---
title: "Docker 的容器重啟政策"
date: 2022-07-28T22:46:42+08:00
tags: [docker]
---


docker 本身有提供重啟政策(restart policy)讓你可以控制容器是否要自動重啟。

## 使用方式

在 docker run 加上 `--restart` flag
```sh
$ docker run -d --restart unless-stopped nginx
```

在 docker-compose.yml，設定 `restart: xxx`

```yml
services:
  nginx:
    image: nginx:latest
    restart: always
```

## 支援四種政策
- `no`
- `on-failure[:max-retries]`
- `always`
- `unless-stopped`

### no

- 容器不會自動重啟
- 預設的重啟政策

### on-failure

- 在容器異常停止運作時會重啟容器
- 容器是否異常停止會看 exit code 是什麼，非 0 就是異常
- 可以額外限制嘗試重啟的次數

### always

- 如果容器停止運作，會一直重啟
- 如果手動停止容器，只會在 docker 常駐程式(daemon) 重啟後重啟

### unless-stopped

- 跟 `always` 相似
- 差別是 docker 常駐程式重啟後不會重啟容器

## 後記

懶人做法就是需要容器常註時，就是 `restart: always`。

## Reference

- https://docs.docker.com/config/containers/start-containers-automatically/
- https://docs.docker.com/compose/compose-file/compose-file-v3/#restart
