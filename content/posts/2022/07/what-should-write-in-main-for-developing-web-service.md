---
title: "開發 web service 的 main.go 需要寫什麼"
date: 2022-07-31T02:16:01+08:00
tags: [go]
---
想要用 go 開發一個 web service 很簡單，網路上有一大堆的範例，
但是通常你不太可能直接拿著範例就上戰場打仗。要應用在現實中的場景，通常還需要加一些程式。

這裡我以開發 web service 為例，整理一下目前我會在 `main.go` 寫什麼

## go mod init

go mod 在 1.13 開始做為 go 預設的查件管理工具

要新增一個專案就會從 go mod 指令開始

```sh
$ go mod init <project path>
```

## 建立 Web Service - Gin

[Gin](https://github.com/gin-gonic/gin) 是用 go 寫的 web 框架，是目前的熱門框架之一，我們就先使用 gin 寫一個簡單的 web service

首先是安裝套件
```sh
$ go get -u github.com/gin-gonic/gin
```

`main.go` 程式如下，基本上就跟官網的範例一樣
```go
package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()
	r.GET("/hello", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{"message": "hello world"})
	})
	r.Run()
}
```

執行程式
```sh
$ go run main.go
```

用 `curl` 測試我們寫的服務是有正確運作的，輸出如下
```sh
$ curl -i http://localhost:8080/hello
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8
Date: Sat, 30 Jul 2022 14:34:50 GMT
Content-Length: 25

{"message":"hello world"}
```

## 設定 logger - zap

程式執行的過程通常都需要寫 log，go 原生就有 log 套件，但是比較陽春一些。

我目前習慣用 [zap](https://github.com/uber-go/zap)，可以結構化的處理 log、有 log level、比原生的 logger 還快，使用起來很舒服

安裝套件
```sh
$ go get -u go.uber.org/zap
```

在 `main()` 裡面依照我們寫 log 的需要產生 logger，再設定成全域的 logger，程式如下
```go
main() {
	logger, _ := zap.NewProduction()
	zap.ReplaceGlobals(logger)
	zap.L().Info("set global logger")
	...
}
```

執行程式後，我們就可以在終端機看到一行 json 格式的 log
```json
{"level":"info","ts":1659192248.8632162,"caller":"lab-go/main.go:13","msg":"hello"}
```

## 設定組態(config) - viper

當我們的程式漸漸成長之後，會開始有一些東西不適合再寫在程式裡，需要搬到 configuration 檔案中。

我目前慣用的套件是 [viper](https://github.com/spf13/viper)，除了檔案型式的 config 之外，還支援很多不同的型式載入 config

安裝套件
```sh
$ go get github.com/spf13/viper
```

建立 `config.yml`
```yml
message: "hello viper"
```

在 `main()` 裡面增加載入 `config.yml` 的設定，程式如下
```go
main() {
	...
	viper.SetConfigType("yml")
	viper.SetConfigName("config")
	viper.AddConfigPath(".")
	err := viper.ReadInConfig()
	if err != nil {
		zap.L().Fatal("read config", zap.Error(err))
	}
	zap.L().Info("config", zap.String("message", viper.GetString("message")))
	...
}
```

上面的程式還有讀取 config 中的 message ，並寫到 log 中。所以執行程式成功時，會看到以下的 json
```json
{"level":"info","ts":1659203896.121547,"caller":"lab-go/main.go:29","msg":"config","message":"hello viper"}
```

## 連接資料庫 - go-sql-driver

web service 是無狀態的服務，通常會搭配資料庫來存放資料狀態，這邊範例我們就使用 MySQL。

這時候我們就可以使用前面設定好的 `zap` 跟 `viper`
- 把連接資料庫用的 DSN 放在 `config.yml` 透過 `viper` 載入程式
- 過程中的接到的錯誤就用 `zap` 寫 log


安裝套件
```sh
$ go get -u github.com/go-sql-driver/mysql
```

增加 dsn 設定到 `config.yml`
```yml
database:
  dsn: "root:root@/testing"
```

記得要 import driver
```go
import (
	"database/sql"
	...

	_ "github.com/go-sql-driver/mysql"
)
```

在 `main()` 裡面增加 MySQL 的連線設定，然後執行 `Ping()` 確認是可以成功連上 MySQL，程式如下
```go
main() {
	...
	db, err := sql.Open("mysql", viper.GetString("database.dsn"))
	if err != nil {
		zap.L().Fatal("sql open", zap.Error(err))
	}
	err = db.Ping()
	if err != nil {
		zap.L().Fatal("ping db", zap.Error(err))
	}
	...
}
```

## 總結

一路增加了一堆東西，我們的 `main.go` 的流程大概如下
1. setting logger
2. setting config
3. setting db connection
4. setting web service
5. run web service

如果還有需要在程式啟動後就初始化的東西，當然就是繼續的往上加。最好的情況是遵守 `Fail Fast` 原則，在主服務開始運作之前，所有必要東西都可以就定位。這樣可以減少執行過程中出現例外錯誤造成程式異常終止的狀況，讓我們的 web 服務更加穩定。

如果需要開始建立資料夾時，我會參考 [Standard Go Project Layout](https://github.com/golang-standards/project-layout) 的佈置來安排資料夾跟檔案。

最後附上程式碼

### 完整版程式碼

最終版把 web 要監聽的 port 也設定到 `config.yml`

`config.yml`
```yml
message: "hello viper"

database:
  dsn: "root:root@/testing"

web:
  port: "8888"
```

`main.go`
```go
package main

import (
	"database/sql"
	"fmt"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/spf13/viper"
	"go.uber.org/zap"

	_ "github.com/go-sql-driver/mysql"
)

func main() {
	// setting logger
	logger, _ := zap.NewProduction()
	zap.ReplaceGlobals(logger)
	zap.L().Info("set global logger")

	// setting config
	viper.SetConfigType("yml")
	viper.SetConfigName("config")
	viper.AddConfigPath(".")
	err := viper.ReadInConfig()
	if err != nil {
		zap.L().Fatal("read config", zap.Error(err))
	}
	zap.L().Info("config", zap.String("message", viper.GetString("message")))

	// setting db connection
	db, err := sql.Open("mysql", viper.GetString("database.dsn"))
	if err != nil {
		zap.L().Fatal("sql open", zap.Error(err))

	}
	err = db.Ping()
	if err != nil {
		zap.L().Fatal("ping db", zap.Error(err))
	}

	// setting web service
	r := gin.Default()
	r.GET("/hello", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{"message": "hello world"})
	})

	// run web service
	viper.SetDefault("web.port", "8080")
	err = r.Run(fmt.Sprintf(":%s", viper.GetString("web.port")))
	if err != nil {
		zap.L().Fatal("run web service", zap.Error(err))
	}
}
```

## Reference

- https://github.com/gin-gonic/gin
- https://github.com/uber-go/zap
- https://github.com/spf13/viper
- https://github.com/go-sql-driver/mysql
- https://github.com/golang-standards/project-layout
- [什麼是快速失敗 (Fail Fast) | Nyo's Study Book](/posts/2021/07/what-is-fail-fast/)
