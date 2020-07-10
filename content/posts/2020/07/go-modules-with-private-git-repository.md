---
title: "Go Modules With Private Git Repository"
date: 2020-07-11T02:43:49+08:00
tags: [go]
---

go **1.14** 開始，go modules 可以在正式環境上使用了

你可能會建立自己私人的工具庫，這時要搭配 go modules 就需要做一些設定

## 基本的設定

假設現在要建立一個私有 module 倉庫，放在 `gitlab.com/nyogjtrc/module`

```
mkdir module
cd module
```

啟用 go module

```
go mode init gitlab.com/nyogjtrc/module
```

## 抓取私有套件

假設要抓取私有套件 `gitlab.com/nyogjtrc/module`

抓取套件時，go get 預設會到 https://proxy.golang.org/ 抓取

私有的套件要設定 `GOPRIVATE`，這樣 go get 會跳過 proxy 直接取得套件

```
go env -w GOPRIVATE=gitlab.com/nyogjtrc/module
```

要存取私有倉庫可以透過 ssh 協定

把 ssh public key 設定到放 git hosting 服務上，再設定 git config

```
git config --global url."git@gitlab.com:".insteadOf "https://gitlab.com/"
```

可以正常使用了

```
go get gitlab.com/nyogjtrc/module
```

---

### Reference

- https://blog.wu-boy.com/2020/03/read-private-module-in-golang/
- https://medium.com/swlh/go-modules-with-private-git-repository-3940b6835727
