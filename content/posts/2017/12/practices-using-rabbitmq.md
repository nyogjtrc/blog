---
title: "Practices Using Rabbitmq"
date: 2017-12-07T16:06:17+08:00
tags: []
draft: true
---

# 安裝服務

直接使用 docker image

```
$ docker pull rabbitmq:3-management
```

# start service

```
$ docker run -d -p 5672:5672 -p 15672:15672  rabbitmq:3-management
```

# management

http://127.0.0.1:15672/

default user guest / guest

# publish message with golang

連上 RabbitMQ
建立 channel
宣告 queue
發佈 message

# recive message with golang

連上 RabbitMQ
建立 channel
宣告 queue
接收 message

# rabbit hunter

https://github.com/nyogjtrc/practice-go/tree/master/rabbitMQ
