---
title: 'Linux 指令 date'
date: 2017-03-04T15:46:00+08:00
tags: [linux,date]
---
今天要來和 linux 約會(誤

---

date 是用來看時間或是設定時間用的指令

不加任何的參數可以直接看目前的時間

```bash
$ date
Sat  4 Mar 23:52:51 CST 2017
```

## 參數

`-d STRING` 輸出字串所描述的日期

```bash
$ date -d 'yesterday'
Sat  4 Mar 00:29:53 CST 2017
```

`-I[FMT]` 用 ISO 8601 的格式輸出
FMT 預設為 date 輸出日期而已，FMT 為 s 時會輸出到秒

```bash
$ date -Is
2017-03-05T01:08:35+08:00
```

`+FORMAT` 輸出指定格式

```bash
$ date +'%F %a'
2017-03-05 Sun
```

然後就可以用來製造你想要的日期列表了

```bash
$ MYLIST=("next sun" "next sat" " next fri" "next thu" "next wed" "next tue" "next mon");
for i in 0 1 2 3 4 5 6; do date -d "${MYLIST[$i]}" +"%F %a"; done;
2017-03-12 Sun
2017-03-11 Sat
2017-03-10 Fri
2017-03-09 Thu
2017-03-08 Wed
2017-03-07 Tue
2017-03-06 Mon
```

### Reference
`man date`
