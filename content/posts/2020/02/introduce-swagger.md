---
title: "Swagger 入門"
date: 2020-02-23T22:21:45+08:00
tags: [swagger]
---

Swagger 官網: https://swagger.io/

## 什麼是 Swagger

Swagger 提供了一個規格來描述 API 長什麼樣子。

有了統一的規格，延伸出一系統的工具來輔助開發 API。

目前最新的 Spec 是 OAS (OpenAPI Specification) 3.0: https://swagger.io/specification/

## 開源工具

Swagger 團隊身有開源三種工具

### Swagger Codegen

- 產生程式碼，生成假 server, client sdk
- https://github.com/swagger-api/swagger-codegen

### Swagger Editor

- 編輯器，有語法檢查，同步產生文件頁面
- https://github.com/swagger-api/swagger-editor
- Live Demo: https://editor.swagger.io/

用 Docker 執行

```
docker run -d -p 80:8080 swaggerapi/swagger-editor
```

### Swagger UI

- 生成 API 文件頁面
- https://github.com/swagger-api/swagger-ui
- Live Demo: https://petstore.swagger.io/

用 Docker 執行

```
docker run --rm -p 8080:8080 -e SWAGGER_JSON=/docs/index.yml -v $(PWD)/docs:/docs swaggerapi/swagger-ui
```

## 使用 Swagger

目前我是直接在專案的 docker-compose.yml 中放入 swagger-ui，方便我直接查看文件

而在正式環境中，還要考慮這份文件開放目標，要設定 Proxy 或是 CORS 等等
