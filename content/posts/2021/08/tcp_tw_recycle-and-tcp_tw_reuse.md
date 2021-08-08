---
title: "tcp_tw_recycle and tcp_tw_reuse"
date: 2021-08-08T18:47:48+08:00
tags: [linux, tcp]
---

如果你遇過 linux server 上有著大量 `TIME_WAIT` 你一定在 google 上看過把 `net.ipv4.tcp_tw_recycle` 跟 `net.ipv4.tcp_tw_reuse` 設定為 `1` 的優化方法，想要介此來減少 `TIME_WAIT` 或是增加 server 可以處理的連線數量

但是這些做法可能是無效的，甚至是「有風險在」的

在 [tcp(7)](https://man7.org/linux/man-pages/man7/tcp.7.html
) 的 man page 有清楚的說明

> tcp_tw_recycle (Boolean; default: disabled; Linux 2.4 to 4.11)
     Enable fast recycling of TIME_WAIT sockets.  Enabling this
     option is not recommended as the remote IP may not use
     monotonically increasing timestamps (devices behind NAT,
     devices with per-connection timestamp offsets).  See RFC
     1323 (PAWS) and RFC 6191.

> tcp_tw_reuse (Boolean; default: disabled; since Linux 2.4.19/2.6)
     Allow to reuse TIME_WAIT sockets for new connections when
     it is safe from protocol viewpoint.  It should not be
     changed without advice/request of technical experts.

在 [Coping with the TCP TIME-WAIT state on busy Linux servers](https://vincent.bernat.ch/en/blog/2014-tcp-time-wait-state-linux) 這篇文章中，有完整的 TCP 運作狀態說明

## tcp_tw_recycle

在 NAT 設備後面的 server 如果啟用 `tcp_tw_recycle` 會造成一些難以追查的連線中斷問題

在 kernel 4.12 版本開始，`tcp_tw_recycle` 因為無法正常運作已經被移除，詳細的原因可以參考 [4396e46187](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4396e46187ca5070219b81773c4e65088dac50cc) 這個 commit

> tcp: remove tcp_tw_recycle
The tcp_tw_recycle was already broken for connections
behind NAT, since the per-destination timestamp is not
monotonically increasing for multiple machines behind
a single destination address.
>
> After the randomization of TCP timestamp offsets
in commit 8a5bd45f6616 (tcp: randomize tcp timestamp offsets
for each connection), the tcp_tw_recycle is broken for all
types of connections for the same reason: the timestamps
received from a single machine is not monotonically increasing,
anymore.
>
> Remove tcp_tw_recycle, since it is not functional. Also, remove
the PAWSPassive SNMP counter since it is only used for
tcp_tw_recycle, and simplify tcp_v4_route_req and tcp_v6_route_req
since the strict argument is only set when tcp_tw_recycle is
enabled.

所以在 4.12 以後的版本，已經沒有 `tcp_tw_recycle` 這個設定可以使用，而在 4.12 之前的版本則不建議啟用這個設定。

## tcp_tw_reuse

在 server 端啟用 `tcp_tw_reuse` 對於要進來的連線沒有幫助

在 client 端啟用 `tcp_tw_reuse` 可以允許 `TIME_WAIT` 連線被使用在新建立要出去的連線，這個設定基本上是安全的

## Summary

大部份的情況下 `TIME-WAIT` 是無害的，並不會佔用太多資源

比修改 `tcp_tw_recycle` 跟 `tcp_tw_reuse`，有很多更適合的方法可以幫助解決問題
ex:
- 增加可用 port 數量
- 增加可用 IP 數量

---

## Reference
[linux - Why is tcp_tw_reuse turned off by default? - Stack Overflow](https://stackoverflow.com/questions/10937828/why-is-tcp-tw-reuse-turned-off-by-default)
[Coping with the TCP TIME-WAIT state on busy Linux servers](https://vincent.bernat.ch/en/blog/2014-tcp-time-wait-state-linux)
[linux - tcp_tw_reuse vs tcp_tw_recycle : Which to use (or both)? - Stack Overflow](https://stackoverflow.com/questions/6426253/tcp-tw-reuse-vs-tcp-tw-recycle-which-to-use-or-both)
