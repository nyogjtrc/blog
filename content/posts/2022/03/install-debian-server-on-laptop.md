---
title: "拿筆電安裝 Debian server"
date: 2022-03-25T00:55:58+08:00
tags: [linux, debian, sudo]
---

把以前的舊筆電翻了出來，發現還可以正常運作，所以打算重灌來拿當做測試用 Server，這篇簡單的記錄一下這次重灌做了什麼事

筆電：ThinkPad t420s

## 作業系統

依舊偏好 Debian，目前 Debian 11.2 (codename: `bullseye`)

下載 Debian [ISO 檔](https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.2.0-amd64-netinst.iso) 或 [包含非自由韌體的 ISO 檔](https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/11.2.0+nonfree/amd64/iso-cd/firmware-11.2.0-amd64-netinst.iso)

## 下載 Rufus 製作開機 USB

https://rufus.ie/ 這是一個在 windows 上製作開機 USB 的工具，之前用過幾次覺得還算順手，也沒有遇到什麼問題

- 插入 USB
- 裝置：選 USB
- 開機模式：選 Debian 映象檔


## 安裝 Debian
- 磁碟分割：沒有要做什麼大工程，就直接選整顆硬碟
- 套件選擇：因為當 server 使用，所以我選了 ssh server

## 安裝後的設定

### 不要讓筆電關上銀幕時睡著

因為是拿筆電來當 server，所以螢幕蓋上就會待機，需要關掉這個功能

修改 `/etc/systemd/logind.conf`

```conf
HandleLidSwitch=ignore
HandleLidSwitchExternalPower=ignore
HandleLidSwitchDocked=ignore
```

### 設定 sudo

安裝 sudo
```
$ sudo apt install sudo
```

在 `/etc/sudoers.d/` 建立一個檔案 `user` 或你想要的檔名，加入以下設定 (user 換成你的帳號)

```
user ALL=(ALL) NOPASSWD: ALL
```

## 後續

還沒想好要做什麼，在這個什麼服務都有 container 的時代，Docker 是一定會裝的 
