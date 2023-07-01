---
title: "將 Debian 11(Bullseye) 升級到 12(Bookworm)"
date: 2023-07-01T22:58:59+08:00
tags: [linux, debian]
---
Debian 在 2023-06-10 釋出 12 代號 bookworm。

我手邊的 server 安裝的是 Debian 11，剛好就找個時間升級一下，順便寫一下筆記

## 升級前準備

先將系統升級到 11 (bullseye) 的最新版，並移除不需要的套件
```
$ sudo apt update && sudo apt upgrade -y
$ sudo apt --purge autoremove
```

請記得評估要做哪些`備份`

## 更新 sources.list

修改 `/etc/apt/sources.list` 內容，將所有的 `bullseye` 改成 `bookworm`，`vi` 可以用 `:%s/bullseye/bookworm/g` 快速取代

更新套件資訊
```
$ sudo apt update
```

## 升級

為了避免完整升級可能照成大量的套件被移除，官方升級文件建議分成兩步升級。先執行最小升級，確認升級的衝突都解除之後，再執行完整升級。

執行最小系統升級
```
$ sudo apt upgrade --without-new-pkgs
```

升級過程中會跳出一些確認選項，請依照情況做選擇


## non-free-firmware

```
N: Repository 'Debian bookworm' changed its 'non-free component' value from 'non-free' to 'non-free non-free-firmware'
N: More information about this can be found online in the Release notes at: https://www.debian.org/releases/bookworm/amd64/release-notes/ch-information.html#non-free-split
```
在我的升級過程跳出了以上的訊息，發現是我少處理了 `non-free-firmware` d的部份。

Debian 12 (bookworm) 開始，已將非自由韌體從 non-free 移到 non-free-firmware，所以要在 `/etc/apt/sources.list` 增加 `non-free-firmware` 這個 component，以下提供一個範本

```
deb http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
```


## 檢查

更新完畢後，檢查一下是否升級到 Debian 12
```
$ lsb_release -a
No LSB modules are available.
Distributor ID: Debian
Description:    Debian GNU/Linux 12 (bookworm)
Release:        12
Codename:       bookworm
```

最後再檢查過自己 server 上有裝的服務是否正常運作，就可以收工了！


## Reference

- [Chapter 4. Upgrades from Debian 11 (bullseye)](https://www.debian.org/releases/stable/i386/release-notes/ch-upgrading.html)
