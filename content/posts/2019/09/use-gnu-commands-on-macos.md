---
title: "在 Mac 上使用 GNU Commands"
date: 2019-09-26T00:48:40+08:00
tags: [mac, gnu, linux]
---

最近突然拿到一台 MacBook Pro，摸了幾天一直很不習慣。

macOS 的核心是基於 Unix 所開發的，terminal 中預設搭載的 command 跟 Linux 差非常的大

這讓習慣以 Linux 開發程式的人很不適應。

好在 Linux 裡常用的 command 都是 gnu 的自由軟體，我們可以直接使用 `brew` 安裝到 macOS 中

## Install GNU Tools

直接使用以下指令把一些常用的工具裝好

```sh
$ brew install coreutils findutils gnu-tar gnu-sed gnu-which gawk gnutls grep gzip wget
```

剛安裝好的 commands 會已掛上前綴 g 的型式設定在 terminal 環境中，如果想要直接使用則需要把 gnubin 資料夾加入 PATH 中
```sh
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
```

### Colorize ls

```sh
alias ls='ls --color=tty'
```

## Update GNU Tools

有一些 macOS 本身就有安裝的工具也順手更新一下

```sh
$ brew install bash less make
```

## Update Non GNU Tools

另外再裝幾個好用的開源工具

```sh
$ brew install git python rsync zsh
```

---

### Reference

- [List of GNU Core Utilities commands - Wikipedia](https://en.wikipedia.org/wiki/List_of_GNU_Core_Utilities_commands)
- [terminal - How to replace Mac OS X utilities with GNU core utilities? - Ask Different](https://apple.stackexchange.com/questions/69223/how-to-replace-mac-os-x-utilities-with-gnu-core-utilities)
- [Install and Use GNU Command Line Tools on macOS/OS X - Top Bug Net](https://www.topbug.net/blog/2013/04/14/install-and-use-gnu-command-line-tools-in-mac-os-x/)
