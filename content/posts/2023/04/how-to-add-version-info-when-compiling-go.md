---
title: "如何在編譯 Go 時加入程式版本資訊"
date: 2023-04-10T22:25:01+08:00
tags: [go]
---

這裡有一段程式，執行時加上 `-v` 的參數就可以秀出程式的版號

```go
package main

import (
	"flag"
	"fmt"
)

const Version = "v0.1.0"

func main() {
	var flagVersion bool
	flag.BoolVar(&flagVersion, "v", false, "version")
	flag.Parse()

	switch {
	case flagVersion:
		fmt.Println("Version:", Version)
	default:
		fmt.Println("Hello world")
	}
}
```

編譯程式
```
$ go build main.go
```

執行時代入 `-v` 參數，成功印出版號
```
$ ./main -v
Version: v0.1.0
```

接下來的問題來了，如果要更新版號，你會怎麼做呢?

修改 `Version` 常數嗎?
```go
const Version = "0.2.0"
```
這個方法太糟糕了，我們有更好的辦法

## 在編譯時加入版號

首先要宣告一個全域的變數 `var Version string`，然後在編譯時使用 `-ldflags` 這個參數加入我們所需要的版號

```go
package main

import (
	"flag"
	"fmt"
)

var Version string

func main() {
	var flagVersion bool
	flag.BoolVar(&flagVersion, "v", false, "version")
	flag.Parse()

	switch {
	case flagVersion:
		fmt.Println("Version:", Version)
	default:
		fmt.Println("Hello world")
	}
}
```

編譯程式，並寫入版號 `v0.2.0`
```bash
$ go build -ldflags "-X main.Version=v0.2.0" main.go
```

執行程式，成功印出 `v0.2.0`
```bash
$ ./main -v
Version: v0.2.0
```

如果有 `git tag`，可以使用 `git describe --tags`

```bash
$ go build -ldflags "-X main.Version=$(git describe --tags)" main.go
```

## 搭配 Makefile 編譯程式

搭配 Makefile 可以省下組合編譯指令參數的時間，還可以放入更多的參數

建立 Makefile 在編譯寫入版號跟編譯時間，內容如下:
```makefile
version := $(shell git describe --tags)
buildtime := $(shell date +'%FT%T%z')

build:
	go build -ldflags \
		"-X main.Version=$(version) \
		-X main.BuildTime=$(buildtime)" main.go
```

程式碼也增加變數 `BuildTime` 來存放時間
```go
package main

import (
	"flag"
	"fmt"
)

var (
	Version   string
	BuildTime string
)

func main() {
	var flagVersion bool
	flag.BoolVar(&flagVersion, "v", false, "version")
	flag.Parse()

	switch {
	case flagVersion:
		fmt.Println("Version:", Version)
		fmt.Println("BuildTime:", BuildTime)
	default:
		fmt.Println("Hello world")
	}
}
```

執行編譯
```bash
$ make build
```

執行程式成功印出編譯時寫入的資訊
```bash
$ ./main -v
Version: v0.2.0
BuildTime: 2023-04-10T22:03:08+0800
```

## Reference
- [ProgrammingPercy - Modify Variables In Go Binary During Build](https://programmingpercy.tech/blog/modify-variables-during-build/)
- [Include the last Git Commit in the output of your Go program version](https://web3.coach/golang-include-last-git-commit-in-your-go-program-version)
- [3 ways to embed a commit hash in Go programs | Red Hat Developer](https://developers.redhat.com/articles/2022/11/14/3-ways-embed-commit-hash-go-programs)

