---
title: "ThinkPad X1 Carbon 6th 的 Debian 安裝記錄"
date: 2018-12-03T14:53:59+08:00
tags: [debian]
draft: true
---

入手 ThinkPad X1c 來當工作機

在使用了幾天不習慣的 windows 10 確定機器沒有什麼問題之後，
就把 OS 換成 Debian 了

## 安裝 Debian 之前

更新 BIOS 到目前最新的版本 1.34

調整以下的設定:

* Security -> Secure Boot - Set to "Disabled"
* Config -> Power -> Sleep State - Set to "Linux"
* Config -> Thunderbolt BIOS Assist Mode - Set to "Enabled"

## 安裝 Debian

Linux Distribute: Debian testing

Partition: whole disk with LVM

Desktop: gnome

## 安裝 Debian 之後

## 設定 sudo

```
# adduser nyo sudo
# reboot
```

## 修改 apt source list

source list 加入 contrib non-free

```
deb http://deb.debian.org/debian/ buster main contrib non-free
deb-src http://deb.debian.org/debian/ buster main contrib non-free

deb http://security.debian.org/debian-security buster/updates main contrib non-free
deb-src http://security.debian.org/debian-security buster/updates main contrib non-free
```

`$ sudo apt install aptitude`

## 安裝 firmware, microcode, fwupd

wifi, bluetooth 等裝置需要的 firmware

`$ sudo apt install firmware-iwlwifi firmware-misc-nonfree`

Intel microcode

`$ sudo apt install intel-microcode`

fwup BIOS 更新軟體

`$ sudo apt install fwupd`

## 下載自己的 dotfiles

建立 ssh key: `$ ssh-keygen -t rsa -b 4096`

```
$ sudo apt install -y git
$ git clone git@github.com:nyogjtrc/dotfiles.git .dotfiles
```
## 安裝常用的 cli 程式

`$ ~/.dotfiles/installation/basic.sh`

https://github.com/nyogjtrc/dotfiles/blob/master/installation/basic.sh

## 安裝 gcin 輸入法

```sh
$ sudo apt install gcin
$ sudo im-config
```

放置嘸蝦米 gtab 到 `~/.gcin/`


## gdm3 停用 Wayland

過程遇到一些問題，像是登入畫面無法正常顯示，輸入法未啟動等等

最後是停用 Wayland 就正常

修改 `/etc/gdm3/daemon.conf`

```
[daemon]
# Uncomment the line below to force the login screen to use Xorg
WaylandEnable=false
```

## 安裝 gnome sell extension

[目前使用中的 GNOME Shell Extensions](posts/2018/12/gnome-shell-extensions-currently-using)

## 設定 gnome 桌面主題

NumixPack: https://www.opendesktop.org/p/1137261/

截圖
![](posts/2018/12/Screenshot_from_2018-12-02_20-46-54.png)


## 安裝防火牆

```sh
$ sudo apt install ufw
$ sudo ufw enable
```
## grub 開機時間

`sudo vi /etc/default/grub`

預設為 5 秒 `GRUB_TIMEOUT=5` 改成 1 秒 `GRUB_TIMEOUT=1`

存檔後更新 grub: `sudo update-grub`

## 待處理

* 電源管理
* SSD 優化

## 目前不支援的装置

* 4G Fibocom L850-GL
* Fingerprint Reader

### Reference
- https://wiki.archlinux.org/index.php/Lenovo_ThinkPad_X1_Carbon_(Gen_6)
- https://medium.com/@hkdb/ubuntu-18-04-on-lenovo-x1-carbon-6g-d99d5667d4d5
