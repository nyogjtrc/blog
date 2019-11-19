---
title: "在 Amazon Linux 2 上安裝 Docker"
date: 2019-11-20T00:42:43+08:00
tags: [docker,aws]
draft: true
---

最近要在偶然拿到手的 EC2 instance 上安裝 docker，卻意外的無法照著官網的說明安裝！

原來是我拿到的 instance 是裝 Amazon Linux 2 這個 AWS 的特別版 OS

沒辦法直接使用一般的 yum 去安裝

而是提供 `amazon-linux-extras` 這個工具讓你來使用

## 在 Amazon Linux 2 安裝 docker

0. 安裝 docker

```bash
$ sudo yum update -y

$ sudo amazon-linux-extras install docker
```

0. 啟用 docker 服務

```bash
$ sudo service docker start
```

0. 將 ec2-user 加入 docker 群組

```bash
$ sudo usermod -a -G docker ec2-user
```

0. 加入群組後要登出再登入才會生效

0. 最後做個簡單的測試

```bash
$ docker info
```

### Reference

- [Amazon ECS 的 Docker 基本概念](https://docs.aws.amazon.com/zh_tw/AmazonECS/latest/developerguide/docker-basics.html)
