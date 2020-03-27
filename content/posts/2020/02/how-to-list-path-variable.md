---
title: "把 PATH 變數列成清單"
date: 2020-02-15T21:04:39+08:00
tags: [bash, linux]
---

在 Linux 的 Shell 環境中，要查看 `PATH` 變數時，通常都是 `echo $PATH`

當 `PATH` variable 中包含太多資料夾時，跟本看不懂

改以清單的方式顯示 `PATH` 內容

```sh
$ echo $PATH | tr ":" "\n"
/usr/local/sbin
/usr/local/bin
/usr/sbin
/usr/bin
/sbin
/bin
```

```sh
echo "${PATH//:/$'\n'}"
```

```sh
echo -e "${PATH//:/\n}"
```

直接用 echo 的方式好像會因 echo 的版本而有差異

列成清單之後發現一堆重複的路徑…

---

### Reference
- https://stackoverflow.com/questions/40599997/how-to-list-path
