---
title: "清除沒有用的 Docker Image"
date: 2020-11-17T23:32:37+08:00
tags: [docker]
---

寫這篇文章時的 docker 版本

```
$ docker -v
Docker version 19.03.13, build 4484c46d9d
```

## 查看、刪除 Image

- 查看 images `$ docker images`
- 刪除 images `$ docker rmi <image_id>`

正在使用的 image 不能刪除
```
$ docker rmi 63130206b0fa
Error response from daemon: conflict: unable to delete 63130206b0fa (must be forced) - image is being used by stopped container 730c4cddd1ad
```

## 清除沒有用的 Image

- 清除沒有被 tag 的 image
    ```
    $ docker image prune
    ```
- 清除沒有被 tag 也沒有被引用的 image
    ```
    $ docker image prune -a
    ```
- 條件過濾，清除 24 小時以前建立的 image
    ```
    $ docker image prune -a --filter "until=24h"
    ```

### Reference

- https://docs.docker.com/config/pruning
- https://docs.docker.com/engine/reference/commandline/image_prune
