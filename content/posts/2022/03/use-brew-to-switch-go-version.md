---
title: "使用 brew 切換不同的 go 版本"
date: 2022-03-15T01:01:10+08:00
tags: [go, brew]
---

使用 brew 安裝 go 可以很容易在不同的版本中切換。

## Brew

目前我工作環境安裝的 brew 版本是 3.4.1，只要使用 `link`/`unlink` 指令就可以切換。

```
$ brew -v
Homebrew 3.4.1-52-gf0f1eb6
Homebrew/homebrew-core (git revision 0192df1b390; last commit 2022-03-14)
Homebrew/homebrew-cask (git revision 96b4f7dabd; last commit 2022-03-14)
```

## 安裝 go

安裝 go 最新版 (1.17) 跟 go 1.16 版
```
$ brew install go
$ brew install go@1.16
```

這時 go version 是 1.17 版
```
$ go version
go version go1.17.8 darwin/amd64
```

## 切換版本方法一

先 `unlink` 目前的版本，再 `link` 想要切換的版本

切換到 go 1.16
```
$ brew unlink go
Unlinking /usr/local/Cellar/go/1.17.8... 2 symlinks removed.

$ brew link go@1.16
Linking /usr/local/Cellar/go@1.16/1.16.15... 2 symlinks created.
```

go version 變成 1.16，切換版本完成
```
$ go version
go version go1.16.15 darwin/amd64
```

切換回 1.17
```
$ brew unlink go@1.16
Unlinking /usr/local/Cellar/go@1.16/1.16.15... 2 symlinks removed.

$ brew link go
Linking /usr/local/Cellar/go/1.17.8... 2 symlinks created.

$ go version
go version go1.17.8 darwin/amd64
```

## 切換版本方法二

直接 `link` 加 `--overwrite` 直接切換到想要的版本

```
$ brew link --overwrite go@1.16
Linking /usr/local/Cellar/go@1.16/1.16.15... 2 symlinks created.

$ go version
go version go1.16.15 darwin/amd64
```

不同要切回最新版就沒辦法用 `--overwrite` 了
```
$ brew link --overwrite go
Warning: Already linked: /usr/local/Cellar/go/1.17.8
To relink, run:
  brew unlink go && brew link go
```

一樣要 `unlink` + `link` 才可以切換回 1.17
```
$ brew unlink go@1.16
Unlinking /usr/local/Cellar/go@1.16/1.16.15... 2 symlinks removed.

$ brew link go
Linking /usr/local/Cellar/go/1.17.8... 2 symlinks created.

$ go version
go version go1.17.8 darwin/amd64
```
