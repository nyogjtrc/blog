---
title: "使用 ssh Proxyjump"
date: 2020-03-15T22:53:09+08:00
tags: [ssh,jump]
---

server 需要經由跳板登入時有幾種做法

- ssh tunnel
- ProxyCommand
- ProxyJump

這邊介紹 ProxyJump 的用法，算是目前最方便的方法

支援 ProxyJump 的是從 OpenSSH 7.3 開始，在 August 2016 released (http://www.openssh.com/txt/release-7.3)

## ssh 指令加上 -J 參數

經由 jump.host 登入 dist.host

```bash
$ ssh -J jump.host dist.host
```

需要打上 username port 的話，一樣的用法

```sh
$ ssh -J username@jump.host:port username@dist.host:port
```

scp 的話
```sh
$ scp -o 'ProxyJump jump.host' myfile.txt dist.host:/my/dir
```

## 設定 ssh config

編輯 ~/.ssh/config

```conf
### First jumphost. Directly reachable
Host jump
  HostName jump.host

### Host to jump to via jump.host
Host dist
  HostName dist.host
  ProxyJump jump
```

直接 ssh

```sh
$ ssh dist
```

直接 scp

```sh
$ scp filename dist:~/
```


---

### Reference

- https://www.madboa.com/blog/2017/11/02/ssh-proxyjump/
- https://wiki.gentoo.org/wiki/SSH_jump_host
- https://en.wikibooks.org/wiki/OpenSSH/Cookbook/Proxies_and_Jump_Hosts

