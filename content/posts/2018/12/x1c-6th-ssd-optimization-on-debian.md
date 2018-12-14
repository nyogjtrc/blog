---
title: "X1c 6th 在 Debian 裡優化 SSD"
date: 2018-12-14T23:20:57+08:00
tags: [ssd, debian]
---

## SSD 優化的幾個要點

* 啟用 SSD 的 Trim 功能
* 減少非必要的寫入動作
* 掛載暫存資料夾到 Ram 上


## 啟用排程 Trim

```
$ sudo systemctl enable fstrim.timer
Created symlink /etc/systemd/system/timers.target.wants/fstrim.timer → /lib/systemd/system/fstrim.timer.
```

ps. 不建議使用 /etc/fstab 的 discard 選項

## 增加 Mount Options

修改前備份 fstab

```
sudo cp /etc/fstab /etc/fstab.bak
```

修改 `/etc/fstab`，mount options 增加 `noatime`

mount options 的說明可以在 `man mount` 查到

## 啟用 LVM Trim

修改 `/etc/lvm/lvm.conf`， `issue_discards = 0` 為 `issue_discards = 1`

## 掛載 tmpfs

將 /tmp 掛載到 tmpfs 上

sudo vi /etc/fstab 加上以下設定

```
tmpfs   /tmp    tmpfs   defaults,noatime,nodev,nosuid,mode=1777,size=2G 0       0
```

## 測試 ssd 速度

```
sudo hdparm -Tt --direct /dev/nvme0n1
```

## NVMe

要查看 NVMe SSD 的資訊無法使用 hdparm 查詢，要安裝 nvme-cli


---

### Referece
* https://blog.longwin.com.tw/2015/08/linux-ssd-disk-partition-config-2015-2/
* http://yblog.org/archive/index.php/ssd_on_ubuntu_linux_howto
* https://wiki.debian.org/SSDOptimization
* https://wiki.archlinux.org/index.php/Solid_state_drive/NVMe
* https://wiki.archlinux.org/index.php/Solid_state_drive
