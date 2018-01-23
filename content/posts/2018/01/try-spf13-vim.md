---
title: "Try Spf13 Vim"
date: 2018-01-23T22:45:54+08:00
tags: [vim]
---

使用目前最強大的 vim 套件包 **spf13-vim**

## 安裝 vim

需要支援 lua 版本的 vim

### mac

```
$ brew install macvim --with-cscope --with-lua --override-system-vim
$ brew install ctags
```

### debian

```
$ sudo apt install vim vim-gnome vim-doc ctags
```

### windows

我不知道

## 安裝 spf13-vim

有一鍵無腦安裝的指令

```
$ curl http://j.mp/spf13-vim3 -L -o - | sh
```

## 自定義設定檔

有三隻檔案可以自行調整 vimrc

- `.vimrc.before.local`: 載入 spf13-vim 之前會載入這支檔案
- `.vimrc.bundles.local`: 要增減套件
- `.vimrc.local`: 載入 spf13-vim 之後會載入這支檔案

### .vimrc.bundles.local

關掉有問題的套件

```vim
" remove problem bundle
UnBundle 'amirh/HTML-AutoCloseTag'
```

## update bundles

```
$ vim +BundleInstall! +BundleClean +q
```

## vim-go

在 vim 裡面執行指令 `:GoInstallBinaries` 以安裝必要的套件

--------------------------------------

### Reference

- https://github.com/spf13/spf13-vim
- http://spf13.com/post/ultimate-vim-config/
- https://farazdagi.com/2015/vim-as-go-language-ide/
