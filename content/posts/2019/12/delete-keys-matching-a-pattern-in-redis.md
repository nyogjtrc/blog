---
title: "刪除 Redis 中符合 Pattern 的 Key"
date: 2019-12-29T17:47:45+08:00
tags: [redis]
---

用 redis-cli 組合一個清除的指令

```bash
$ redis-cli --scan --pattern users:* | xargs redis-cli unlink
```

1. 用 scan 找出要刪的 key
2. 透過 xargs 傳給 unlink 刪掉 key

### KEYS vs SCAN

一樣都會掃過所有的 key，scan 不會阻塞整個 server，而是迭代的收集結果

### DEL vs UNLINK

一樣都是刪除 key ，差別在於 unlink 是非阻塞的刪除，會以非同步的方式回收記憶體

### Referece
- https://rdbtools.com/blog/redis-delete-keys-matching-pattern-using-scan/
- https://redis.io/commands/scan
- https://redis.io/commands/unlink
