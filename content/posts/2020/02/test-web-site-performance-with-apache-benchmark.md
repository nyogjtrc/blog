---
title: "用 ab (apache benchmark) 測試網站效能"
date: 2020-02-29T01:30:46+08:00
tags: [ab]
---

指令說明: http://httpd.apache.org/docs/current/programs/ab.html

## 安裝

debian

```
sudo apt-get install apache2-utils
```

centos

```
yum install httpd-tools
```

## 執行結果

```
$ ab -n 100 -c 10 https://google.com/
This is ApacheBench, Version 2.3 <$Revision: 1826891 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking google.com (be patient).....done


Server Software:        gws
Server Hostname:        google.com
Server Port:            443
SSL/TLS Protocol:       TLSv1.2,ECDHE-ECDSA-CHACHA20-POLY1305,256,256
TLS Server Name:        google.com

Document Path:          /
Document Length:        220 bytes

Concurrency Level:      10
Time taken for tests:   0.981 seconds
Complete requests:      100
Failed requests:        0
Non-2xx responses:      100
Total transferred:      71000 bytes
HTML transferred:       22000 bytes
Requests per second:    101.95 [#/sec] (mean)
Time per request:       98.091 [ms] (mean)
Time per request:       9.809 [ms] (mean, across all concurrent requests)
Transfer rate:          70.69 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:       41   63  12.2     62     109
Processing:    16   24   9.0     21      56
Waiting:       15   24   8.7     21      56
Total:         64   87  17.8     83     150

Percentage of the requests served within a certain time (ms)
  50%     83
  66%     87
  75%     91
  80%     94
  90%    107
  95%    138
  98%    150
  99%    150
 100%    150 (longest request)
```

## 說明

```
Concurrency Level       (併發數量)
Time taken for tests    (本次壓力測試所花費的總秒數)
Complete requests       (完成的請求數)
Failed requests         (失敗的請求數)
Total transferred       (本次測試的總傳輸量)
HTML transferred        (本次測試的 HTML 傳輸量)
Requests per second     (每秒回應多少請求) (平均值)
Time per request        (每個請求所花費的時間) (ms) (平均值)
Time per request        (每個請求所花費的時間，所有同時連線數的平均值) (ms) (平均值)
Transfer rate           (傳輸速率)

Connection Times

min           最小值
mean[+/-sd]   平均值[標準差]
median        中位數
max           最大值

Connect       建立 TCP 連線的時間花費
Processing    建立 TCP 連線後，Server 處理請求的時間花費
Waiting       發出請求到接到第一個 Byte 的等待時間
Total         總花費時間 (Connect + Processing)
```

## 常用組合

100 個請求量，10 個併發

```
ab -n 100 -c 10 https://google.com/
```

10 個併發，執行 10 秒

```
ab -t 10 -c 10 https://google.com/
```

post json，post 內容為 post.json

```
ab -n 100 -c 10 -p post.json -T application/json https://httpbin.org/post
```

---

### Reference

- https://blog.miniasp.com/post/2008/06/30/Using-ApacheBench-ab-to-to-Web-stress-test
- https://gist.github.com/kelvinn/6a1c51b8976acf25bd78

