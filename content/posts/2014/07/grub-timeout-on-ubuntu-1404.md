---
layout: post
title: 'Ubuntu 14.04  GRUB 開機選單的等待時間'
date: 2014-07-10T10:21:00+08:00
tags: [grub,ubuntu]
---
升級到 Ubuntu 14.04 之後，我的 GRUB 選單跳回預設的自動倒數十秒鐘

對一台換上 SSD 的筆電來說，這十秒鐘實在是太久了

於是乎，該著手來改一下設定了

## 調整設定
執行 `sudo vi /etc/default/grub` 你會看到以下設定

```conf
GRUB_DEFAULT=0
GRUB_HIDDEN_TIMEOUT=0
GRUB_HIDDEN_TIMEOUT_QUIET=true
GRUB_TIMEOUT=10
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
GRUB_CMDLINE_LINUX="locale=zh_TW"
```

我們要改的設定有兩項：
`GRUB_HIDDEN_TIMEOUT` 跟 `GRUB_TIMEOUT`

註解 `GRUB_HIDDEN_TIMEOUT`
設定 `GRUB_TIMEOUT` 至我們要的秒數

最後變成以下的樣子：

```conf
GRUB_DEFAULT=0
#GRUB_HIDDEN_TIMEOUT=0
GRUB_HIDDEN_TIMEOUT_QUIET=true
GRUB_TIMEOUT=1
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
GRUB_CMDLINE_LINUX="locale=zh_TW"
```

存檔之後，再執行 `sudo update-grub` 更新 grub 設定

大功告成，重開機吧！

## Reference
- http://askubuntu.com/questions/148095/how-do-i-set-the-grub-timeout-and-the-grub-default-boot-entry
