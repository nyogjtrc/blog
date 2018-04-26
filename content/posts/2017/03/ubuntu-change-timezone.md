---
title: "Ubuntu Change Timezone"
date: 2017-03-20T22:47:43+08:00
tags: [ubuntu]
---

改變 Ubuntu 的時區，請使用以下指令

```bash
$ sudo dpkg-reconfigure tzdata
```

接著會跳出一個畫面讓你選時區，選好之後會看到以下資訊

```bash
$ sudo dpkg-reconfigure tzdata

Current default time zone: 'Asia/Taipei'
Local time is now:      Mon 20 Mar 22:32:45 CST 2017.
Universal Time is now:  Mon Mar 20 14:32:45 UTC 2017.
```

再 date 看一下時間是否正確

```bash
$ date
Mon 20 Mar 22:32:48 CST 2017
```



### Reference
http://unix.stackexchange.com/questions/110522/timezone-setting-in-linux
