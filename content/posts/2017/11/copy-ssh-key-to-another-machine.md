---
title: "複製 ssh key 到遠端機器"
date: 2017-11-09T13:24:42+08:00
tags: [ssh]
---

發現了可以快速複製 key 到別台機器的好工具
可以不用再傻傻的 copy paste 了

## 產生 key

首先自己要有 ssh key

```sh
$ ssh-keygen
```

## 複製 key 到另一台遠端機器

快速複製的好工具是 `ssh-copy-id`
指令加上 `-i` 指令要複製的 key

執行後你可能要打密碼，因為那台遠端機器上還沒有 key 可以驗證你是誰

```sh
$ ssh-copy-id -i ~/.ssh/mykey user@another-host
user@another-host's password:
```

成功執行後，public key 就會被放進遠端機器的 `authorized_keys` 裡

## 測試

最後實測一下，能不能順利登入

```sh
$ ssh -i ~/.ssh/mykey user@another-host
```

------

## Reference

https://www.ssh.com/ssh/copy-id
https://askubuntu.com/questions/4830/easiest-way-to-copy-ssh-keys-to-another-machine
