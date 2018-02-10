---
title: "Set Sudo on Debian"
date: 2018-02-10T22:24:57+08:00
tags: [sudo, debian, linux]
---

安裝好基本款的 debian 是沒有 sudo 指令可以使用的，需要自行安裝設定


## 安裝 sudo

切換到 root 安裝

```cli
# su -
# apt install sudo
```

## 設定 sudoer

```cli
# usermod -aG sudo nyo
```

設定好之後，登入並用 `sudo` 隨意打個指令試試

```cli
$ sudo ls -l /root
```

成功！

### Reference

https://www.digitalocean.com/community/tutorials/how-to-create-a-sudo-user-on-ubuntu-quickstart
https://unix.stackexchange.com/questions/292562/adding-a-sudoer-in-debian
