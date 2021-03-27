---
title: "Exa: 更棒的 ls 指令"
date: 2021-03-27T14:04:56+08:00
tags: [command-line]
---

exa 是 ls 指令的另一個選擇，使用 rust 開發的

github: https://github.com/ogham/exa

## exa 的特色

- 幫檔案跟一些屬性都上色，更容易閱覽
- 可以用樹狀圖顯示，tree 的另一個選擇
- 可以支援 git status 以及一些額外的檔案資訊
- 執行效能跟 ls 差不多


## 安裝方式

```
$ sudo apt install exa
```

```
$ brew install exa
```

## 設定 alias 取代 ls

```
alias ls='exa'
alias la='exa -a'
alias ll='exa -lh'
alias ls='exa'
alias ll='exa -lh'
alias la='exa -lah'
alias lr='exa -lR'
```

## 實際使用截圖

![](/posts/2021/03/exa.png)
