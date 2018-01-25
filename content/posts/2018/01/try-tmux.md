---
title: "Try Tmux"
date: 2018-01-25T16:11:13+08:00
tags: [tmux]
---

被稱作 Linux 神器的工具

入門之後我也愛上它了，讓 terminal 變得非常的靈活

## 安裝

### mac

```
$ brew install tmux
```

### ubuntu / debian

apt 上裝的可能會太舊，直接裝 github 上最新 release 的

https://gist.github.com/P7h/91e14096374075f5316e

```
VERSION=2.6
sudo apt -y remove tmux
sudo apt -y install wget tar libevent-dev libncurses-dev
wget https://github.com/tmux/tmux/releases/download/${VERSION}/tmux-${VERSION}.tar.gz
tar xf tmux-${VERSION}.tar.gz
rm -f tmux-${VERSION}.tar.gz
cd tmux-${VERSION}
./configure
make
sudo make install
cd -
sudo rm -rf /usr/local/src/tmux-*
sudo mv tmux-${VERSION} /usr/local/src
```


## tmux.conf

```tmux
set -g default-terminal "screen-256color"

# enable mouse
set -g mouse on


# new prefix {
unbind-key C-b
set -g prefix C-a
bind-key C-a send-prefix
# }


# <prefix> + r | reloading config
bind-key r source-file ~/.tmux.conf \; display-message "Yo~! .tmux.conf reloaded!"

bind-key \ split-window -h -c '#{pane_current_path}'
bind-key - split-window -v -c '#{pane_current_path}'
```


## Usage

建立一個新的 session
```
$ tmux
```

建立一個新的 session 並且設定名稱
```
$ tmux new -s name
```

列出目前有的 session
```
$ tmux ls
```

連回 session
```
$ tmux a
```

## Tmux 的畫面

session > window > pane

session: 一個整個 tmux 的畫面
window: 分頁
pane: 切割畫面

## shortcut

```
c create new window
n switch to next window
p switch to previous window

\ split h
- split v

z zoom in/out current pane

w list winodws
s list sessions

d dettach
```

---

### Reference

- https://github.com/tmux/tmux/wiki
- http://fideloper.com/mac-vim-tmux
- https://danielmiessler.com/study/tmux/
- https://gist.github.com/MohamedAlaa/2961058
- https://www.unwiredcouch.com/2013/11/15/my-tmux-setup.html
