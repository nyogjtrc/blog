---
title: "Fix Date Time of Photo Exif Meta Data"
date: 2018-01-14T01:25:15+08:00
tags: [exif]
---

某次旅遊到了不同的時區，但是相機沒有調時間，拍到後來才發現，自己差點沒暈倒

只能回家想辦法再修正時間，畢竟照片不能重拍啊

要在 Linux 上處理 EXIF 的話，有個工具叫 `exiftool` 可以用

## 安裝

```
$ sudo apt install libimage-exiftool-perl
```

## 要看 EXIF

看所有的 EXIF 資料

```
$ exiftool -a -u -g1 IMG_001.jpg
```

看 EXIF 日期資料

```
$ exiftool -AllDate IMG_001.jpg
```

## 要改 EXIF

要改時間可以直接指定日期

```
$ exiftool DateTimeOriginal='2018:01:01 12:11:10' IMG_001.jpg
```

或是加減時間

```
$ exiftool DateTimeOriginal-=2:0:0 -TimeZone=+08:00 IMG_001.jpg
```

有修改 EXIF 時， exiftool 會幫你複製一份原始檔案，並在檔案加上 `_original`

如果不想要備份的話，指令上多加個 `-overwrite_original` 就可以了

## 清 EXIF

```
$ exiftool -all= image.jpg
```

---

### Reference

http://dimitar.me/change-the-date-and-time-or-any-other-exif-image-meta-data-of-pictures-with-ubuntu/
http://blog.elleryq.idv.tw/2015/04/exif-exiftool.html
