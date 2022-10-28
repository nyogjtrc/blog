---
title: 'AWS - 無法登入 EC2 Instance 的解決方案'
date: 2017-03-17T11:10:00+08:00
tags: [aws, ec2]
---
在調整伺服器設定時，一度不小心改錯設定，讓自己無法登入。因為沒有備份，一開始還以為沒救了，打算花時間重新來過

還好意外翻到官方文件上有一篇可以解決方案可以試試。最後成功了，救回不少時間

這個做法的感覺就像是把電腦的硬碟拔下來裝到別台去讀取資料，詳細流程如以下記錄：

### 記錄

1. 查看 Instance 的資訊，把 instance ID, AMI ID, Availability Zone, Root device 記錄下來
2. 點擊 Root device，把 **EBS ID** 記錄下來
3. 把 Instance 關機，選 Actions -> Instance State -> **Stop**

### 建立新的 Instance

1. 點擊 **Launch Instance**
2. 選擇跟剛剛記錄下來一樣的 AMI
3. 在 Configure Instance Details 要選一樣的 Availability Zone
4. 在 Add Tags 加上 Name=Temp
5. 到 Review 頁面點擊 **Launch Instances**

### 將虛擬硬碟裝到新的 Instance 上

5. 到 console 左側的功能列表選 Volumes
6. 找到原 instance 的 volume 卸載，選 Actions -> **Detach Volume**，然後等它處理完畢
7. 把同個 volume 掛載到 temp instance 上，選 Actions -> **Attach Volume** -> 選 temp instance -> 記錄 Device name (ex. /dev/sdf) -> 點 **Yes, Attach**

### 登入 Instance 掛載硬碟

8. 登入 temp instance
9. 接下來要 mount volume
10. 使用 `lsblk` 指令，看到 /dev/sdf 的 device name 以 `xvdf` 顯示，然後磁區名稱會是 xvdf1 (/dev/xvdf1)
11. 下 mount 指令

```bash
$ sudo mkdir /mnt/tempvol
$ sudo mount /dev/xvdf1 /mnt/tempvol
```

12. 接下來就可以進 `/mnt/tempvol` ，解救資料，備份資料，修正設定，都可！

### 硬碟裝回原 Instance

13. 資料解救完畢後 umount

```bash
$ sudo umount /mnt/tempvol
```

14. **Detach Volume** 再重新 **Attach Volume** 掛回原 instance 的 `/dev/sda1`
15. 重新 **Start instance**

### Reference

https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html#replacing-lost-key-pair

