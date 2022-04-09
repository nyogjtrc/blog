---
title: "升級 go.mod 裡的 go version"
date: 2022-04-09T14:43:24+08:00
tags: [go]
---

1.18 都 release 才想要看看怎麼把 go version 改到 1.17

## 修改 `go.mod`

使用 `go mod edit` 修改 `go.mod` 檔案的 go version
```
$ go mod edit -go=1.17
```

go 1.17 的 `go mod tidy ` 增加了 `-go` 參數，可以直接修改 `go.mod` 檔案中的 go version
```
$ go mod tidy -go=1.17
```

## 升級依賴套件

升級依賴套件 + 更新 `go.mod`

```
$ go get -u
$ go mod tidy
```

可以用 `help` 指令看說明
```
$ go mod help edit
$ go mod help tidy
```

## Reference
- [Go 1.17 Release Notes - The Go Programming Language](https://go.dev/doc/go1.17)
- [Managing dependencies - The Go Programming Language](https://go.dev/doc/modules/managing-dependencies)
- [Go Modules Reference - The Go Programming Language](https://go.dev/ref/mod)
