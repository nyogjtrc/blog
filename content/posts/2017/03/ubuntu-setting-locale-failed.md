---
title: "Ubuntu - Setting Locale Failed"
date: 2017-03-20T22:40:37+08:00
tags: [ubuntu]
---

在 AWS 上新開的一台 EC2 主機，ssh 登入操作時跳出一些語系相關的警告訊息

```
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
LANGUAGE = (unset),
LC_ALL = (unset),
LC_TIME = "en_GB.UTF-8",
LC_MONETARY = "en_GB.UTF-8",
LC_ADDRESS = "en_GB.UTF-8",
LC_TELEPHONE = "en_GB.UTF-8",
LC_NAME = "en_GB.UTF-8",
LC_MEASUREMENT = "en_GB.UTF-8",
LC_IDENTIFICATION = "en_GB.UTF-8",
LC_NUMERIC = "en_GB.UTF-8",
LC_PAPER = "en_GB.UTF-8",
LANG = "en_US.UTF-8"
  are supported and installed on your system.
perl: warning: Falling back to a fallback locale ("en_US.UTF-8").
locale: Cannot set LC_ALL to default locale: No such file or directory
```

原因是在 ssh login 時，傳送過去的編碼資料不存在於遠端主機所導致

解決方法很簡單，把編碼的資料建立起來就可以了

```bash
$ sudo locale-gen en_GB.UTF-8
Generating locales (this might take a while)...
  en_GB.UTF-8... done
Generation complete.
```

### Reference

https://ubuntuforums.org/showthread.php?t=1346581
http://askubuntu.com/questions/162391/how-do-i-fix-my-locale-issue

