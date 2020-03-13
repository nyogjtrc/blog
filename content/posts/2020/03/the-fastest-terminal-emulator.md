---
title: "最快速的 Terminal Emulator"
date: 2020-03-13T21:29:26+08:00
tags: [terminal, rust, gpu]
---

發現了使用 GPU 的 terminal emulator

- https://github.com/alacritty/alacritty
- https://sw.kovidgoyal.net/kitty/

我目前幾乎所有的工作都在 terminal 上處理，無法接太慢的 terminal 程式

兩個都試用了一下，決定先以 alacritty 當主力試試

特色:
- 目前最快的 terminal emulator
- 使用 GPU
- 支援 Linux, BSD, macOS, Windows
- rust 開發

## 安裝

### Debian / Ubuntu

```
$ apt install alacritty
```

### macOS

```
$ brew cask install alacritty
```

## 設定

把 alacritty.yml 放到以下的其中的一個位置就可以生效

- `$XDG_CONFIG_HOME/alacritty/alacritty.yml`
- `$XDG_CONFIG_HOME/alacritty.yml`
- `$HOME/.config/alacritty/alacritty.yml`
- `$HOME/.alacritty.yml`


## Color schemes

可以從以下兩個網址去找自己喜歡的顏色

- https://github.com/alacritty/alacritty/wiki/Color-schemes
- https://github.com/eendroroy/alacritty-theme

## 心得

cat log 檔案的時候速度很快，看的感覺很爽快

很可惜的，macOS + tmux + vim 這個組合還是會很慢

有幾個 terminal emulator 設計的很華麗，也有跨多平台。
可惜是用 Electron 開發的，感覺太過肥大，就暫時不考慮了

### Refence

- https://github.com/alacritty/alacritty
