---
title: "Grafana Loki 收集 Log"
date: 2021-12-21T22:20:54+08:00
tags: [grafana, loki, log]
---

[Grafana Loki](https://grafana.com/docs/loki/latest/) 是一個輕量的 log 收集服務。

Loki 的標語 `Like Prometheus,But For Logs` 說明著這個服務靈感來自 Prometheus。跟其他的 log 收集服務比較下，Loki 有以下特性：
- 不對 log 進行全文索引。介由存儲壓縮的非結構化 log 和僅索引 metadata，Loki 操作更簡易而且執行成本更低
- 使用的相同於 Prometheus 的標籤對 logs 進行索引和分組，讓您能夠用相同標籤在 metrics 和 logs 之間無縫切換
- 有 Grafana 原生支援

## Loki 的運作結構

![](/posts/2021/12/Loki-Sample.png)

- Loki：本身負責儲存 log，並且處理查詢請求
- agent：負責收集 log，並推送給 Loki。
	- `Promtail` agent 是 Grafana 團隊專門設計給 Loki 使用的 agent。
	- 當然 Loki 還支援 Logstash, Fluentd 等其他 agent
- Grafana：提供查詢的使用者介面。Grafana 的好用就不需要多介紹了。

## 開始使用 Loki

Grafana 官方有提供 [docker-compose.yml](https://raw.githubusercontent.com/grafana/loki/v2.4.1/production/docker-compose.yaml) 可以直接用他來測試

### 收集 log file

```yml
version: "3"

services:
  loki:
    image: grafana/loki:2.4.1
    ports:
      - "3100:3100"
    command: -config.file=/etc/loki/local-config.yaml

  promtail:
    image: grafana/promtail:2.4.1
    volumes:
      - /var/log:/var/log
    command: -config.file=/etc/promtail/config.yml

  grafana:
    image: grafana/grafana:latest
    ports:
      - "3000:3000"
```

- 啟動 docker-compose
- 打開 grafana http://localhost:3000
- 增加 data source `Loki`，設定 URL `http://loki:3100`
- 打開 Explore，data source 選擇 Loki，就可以依照 label 查詢 log

### 收集 docker logs

Loki 有提供 [Docker Driver Client](https://grafana.com/docs/loki/latest/clients/docker-driver/) 的 Docker plugin，可以直接讀取 container 的 log

安裝 plugin
```bash
$ docker plugin install grafana/loki-docker-driver:latest --alias loki --grant-all-permissions
```

檢查安裝的 plugins
```bash
$ docker plugin ls
```

修改 `docker-compose.yml` 針對要收集 log 的 container 加上 `logging` 的設定

```yml
version: "3"

services:
  loki:
    image: grafana/loki:2.4.1
    ports:
      - "3100:3100"
    command: -config.file=/etc/loki/local-config.yaml

  promtail:
    image: grafana/promtail:2.4.1
    volumes:
      - /var/log:/var/log
    command: -config.file=/etc/promtail/config.yml

  grafana:
    image: grafana/grafana:latest
    ports:
      - "3000:3000"
    logging:
      driver: loki
      options:
        loki-url: "http://localhost:3100/loki/api/v1/push"
```

- 打開 grafana http://localhost:3000
- 你可以在 Explore 看到多了 `grafana` 相關的 Labels

![](/posts/2021/12/grafana-explore.png)

---

- https://github.com/grafana/loki
