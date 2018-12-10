---
title: "查詢 Linux 上的一些 Unique ID"
date: 2018-12-10T11:34:35+08:00
tags: [linux]
---

每台機器都會有一些自己唯一的 id

在開發程式中，可能會有需要用來分辨機器

## machine-id

```
$ cat /etc/machine-id

$ cat /var/lib/dbus/machine-id
```

## product_uuid

```
$ sudo cat /sys/class/dmi/id/product_uuid
```

## MAC address

```
$ ip link
```

## Hard Disk UUID

```
$ blkid

$ ls -l /dev/disk/by-uuid
```

## random UUID

```
$ cat /proc/sys/kernel/random/uuid

$ uuidgen
```


### Reference
https://www.thegeekdiary.com/centos-rhel-7-how-to-change-the-machine-id/
http://0pointer.de/blog/projects/ids.html
https://liquidat.wordpress.com/2013/03/13/uuids-and-linux-everything-you-ever-need-to-know/

