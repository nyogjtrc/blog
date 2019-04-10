---
title: "離開 spf13-vim 的日子"
date: 2019-04-10T16:22:20+08:00
tags: [vim]
---

## 前言


回歸使用 vim 當作主要開發工具後，為了省下調效 vimrc 的時間，決定先用別人整理好的設定，於是乎找到了 [spf13-vim](https://github.com/spf13/spf13-vim)，便開始的了快樂的 vim 生活。

spf13-vim 用了數個月之後，熟悉了不少的設定方式，也調整不少符合自己習慣的設定。

移掉一些老舊的套件，掛上一些新套件。

但是 spf-13 原作終究是停止維護的，要一直從 spf13 擴充做調整會被受限。

所以，決定是時候自己重新組織適合自己的工作環境。也記錄一下這次我是怎麼調效我的 vimrc 的。

## vim 基本設定

主要是參考 spf13-vim 的，畢竟多數的習慣是雷同的


## vim 套件

要尋找套件可以到 https://vimawesome.com/ 上面尋找。

首先是套件管理，從幾個之名的工具中，選一下自己滿意的。

這次選擇使用 `junegunn/vim-plug`


再來是 UI 改善：

* scrooloose/nerdtree
* majutsushi/tagbar
* vim-airline/vim-airline
* luochen1990/rainbow
* shougo/denite.nvim

colorscheme 的話，個人喜歡 `morhetz/gruvbox`

整合工具，整合 git, lint, tmux 等等的工具：

* airblade/vim-gitgutter
* w0rp/ale
* christoomey/vim-tmux-navigator
* benmills/vimux


自動完成，選擇沒那麼肥大的 deoplete：

* Shougo/deoplete.nvim
* Shougo/neosnippet.vim


程式語言，幾乎每個程式語言都會有自己的開發輔助工具，而 vim 套件就是負責整合：

* fatih/vim-go
* StanAngeloff/php.vim
* phpactor/phpactor
* 2072/php-indenting-for-vim


## key map

先把 leader key 換成自己習慣的：

```vim
let mapleader = ',' " Replace leader to ',', default leader is '\'
```

再來就是有海量的快捷鍵要設定跟記憶，

好在大部份作者會給一些範本，也可以在網上路參加別人的設定。


## 後續

最後就是一寫程式一邊視自己的習慣調整設定


## 結語

我的 vimrc 在我的 dotfiles 裡面 https://github.com/nyogjtrc/dotfiles/blob/master/vim/vimrc

回顧一下四年前自己整理曾經整理過的 vimrc ，當時才只有 87 行。

目前整理的有 436 行，資訊量成長 5 倍！！！

