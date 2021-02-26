---
title: "IPv6 簡介"
date: 2021-02-26T23:27:39+08:00
tags: [ipv6]
---

IPv6 是為了解決 IPv4 位址用盡問題而誕生的

長度從 IPv4 的 32 位元增加到 128 位元

## 常用表示方法

使用冒號組合 8 組 4 個十六進位數字

```
ex. 
2001:0db8:86a3:08d3:1319:8a2e:0370:7344
```

## 簡短 IPv6 的規則

- 每一組數字前導的零可以省略
  ```
  ex.
  2001:0db8:02de:0000:0000:0000:0000:0e13
  2001:db8:2de:0:0:0:0:e13
  ```

- 用雙冒號「::」表示連續的 0，但只能出現一次
  ```
  ex.
  2001:db8:2de::e13
  ```

## IPv4 對映位址

IPv4 可以轉換為 IPv6

```
ex.
192.168.35.99
::ffff:192.168.35.99
```

## 特殊 IP
- `::/128` Unspecified Address，未指定位址，相當 IPv4 的 `0.0.0.0`
- `::1/128` Loopback Address，指向本地主機，相當 IPv4 的 `127.0.0.1`
- `::ffff:0:0/96` IPv4-mapped Address，對映 IPv4 使用的網段

### Reference

- https://zh.wikipedia.org/wiki/IPv6
- [IBM Knowledge Center - IPv6 位址格式](https://www.ibm.com/support/knowledgecenter/zh-tw/ssw_ibm_i_72/rzai2/rzai2ipv6addrformat.htm)
- [Internet Protocol Version 6 Address Space](https://www.iana.org/assignments/ipv6-address-space/ipv6-address-space.xhtml)
- [IANA IPv6 Special-Purpose Address Registry](https://www.iana.org/assignments/iana-ipv6-special-registry/iana-ipv6-special-registry.xhtml)
- [IANA IPv4 Address Space Registry](https://www.iana.org/assignments/ipv4-address-space/ipv4-address-space.xhtml)
