---
title: "架設自己的 Gitlab-CI"
date: 2020-02-09T22:29:39+08:00
tags: [gitlab, gitlab-ci, ci]
---

公司裡有一台 gitlab server，但是沒有人在更新，也沒有安裝 CI。

一開始使用覺得沒什麼差，經過沒幾天當我想要試試 CI/CD 時，
突然覺得沒有 CI/CD 的 Gitlab 跟本是個廢物。

所以我自己試著重新安裝了一台 Gitlab + Gitlab-CI。


## 用 APT 在 Ubuntu 上安裝 gitlab

先安裝基本的套件

```
sudo apt-get update
sudo apt-get install -y curl openssh-server ca-certificates
```

加入 gitlab 套件庫

```
curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
```

安裝 gitlab

```
sudo EXTERNAL_URL="https://gitlab.example.com" apt-get install gitlab-ce

```

安裝完畢之後，就可以開 Browser 登入 Gitlab 了，預設的帳號是 root

我用 vm 試過之後，覺得用這方法當要更新時，可能會有點麻煩，所以就改試 Docker 的方法

## 用 Docker 執行 gitlab

前置作業就是在 server 上安裝 docker

接來執行以下 docker 指令，就有一個 gitlab 服務了
```
sudo docker run --detach \
  --hostname gitlab.example.com \
  --publish 443:443 --publish 80:80 --publish 22:22 \
  --name gitlab \
  --restart always \
  --volume /srv/gitlab/config:/etc/gitlab \
  --volume /srv/gitlab/logs:/var/log/gitlab \
  --volume /srv/gitlab/data:/var/opt/gitlab \
  gitlab/gitlab-ce:latest
```

## 用 Docker 安裝 gitlab runner

執行以下 docker 指令
```
docker run -d --name gitlab-runner --restart always \
  -v /srv/gitlab-runner/config:/etc/gitlab-runner \
  -v /var/run/docker.sock:/var/run/docker.sock \
  gitlab/gitlab-runner:latest
```

## 用 docker-compose 安裝 gitlab+gitlab-ci

直接使用 docker-compose 更直接快速的執行 gitlab 跟 runner 服務

```
version: "3"
services:
  web:
    image: 'gitlab/gitlab-ce:latest'
    restart: always
    environment:
      GITLAB_OMNIBUS_CONFIG: |
        external_url 'https://gitlab.example.com'
        gitlab_rails['gitlab_shell_ssh_port'] = 2224
    ports:
      - '80:80'
      - '443:443'
      - '2224:22'
    volumes:
      - '/srv/gitlab/config:/etc/gitlab'
      - '/srv/gitlab/logs:/var/log/gitlab'
      - '/srv/gitlab/data:/var/opt/gitlab'
  runner:
    image: 'gitlab/gitlab-runner:latest'
    restart: always
    volumes:
      - '/var/run/docker.sock:/var/run/docker.sock'
      - '/srv/gitlab-runner/config:/etc/gitlab-runner'
```

如果要更新，只要兩個指令

```
docker-compose pull
docker-compose up -d
```

## 把 runner 註冊到 gitlab 裡

先到 Admin Area > Overview > Runners 頁面，找到 registration token

執行 register 指令
```
docker run --rm -t -i -v /srv/gitlab-runner/config:/etc/gitlab-runner gitlab/gitlab-runner register
```

選項請參考官網 https://docs.gitlab.com/runner/register/

如果 Gitlab 有啟用 SSL，你可能需要帶上 crt file
```
docker run --rm -t -i -v /srv/gitlab-runner/config:/etc/gitlab-runner gitlab/gitlab-runner register \
  --tls-ca-file=/srv/gitlab/config/ssl/gitlab.example.com.crt
```

回到 Admin Area > Overview > Runners 頁面，看到 runner 的資料出現了。

之後就是試用 Gitlab-CI 的時間了！

---

### Reference

- https://about.gitlab.com/install/
- https://docs.gitlab.com/omnibus/docker/
- https://docs.gitlab.com/runner/register/
- [如何用 Docker 建制 Self-Host 的 GitLab 和 GitLab CI - Rukeith - Medium](https://medium.com/@rukeith/%E5%A6%82%E4%BD%95%E7%94%A8-docker-%E5%BB%BA%E5%88%B6-self-host-%E7%9A%84-gitlab-%E5%92%8C-gitlab-ci-5f70a74a26a5)
