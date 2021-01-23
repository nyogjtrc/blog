---
title: "Makefile: Phony Targets"
date: 2021-01-24T02:48:08+08:00
tags: [makefile]
---

## Makefile Rule

Makefile Rule 格式如下

```makefile
target: prerequisites
	recipe
```

- target: 要產生的檔案名稱
- prerequisites: 產生 target 所需要的檔案
- recipe: 要執行的動作

這裡準備一個寫 golang 會用到的 Makefile 如下面:

```makefile
build:
	go build -o main main.go
```

執行 `make build`，Make 會先檢查有沒有 `build` 這個檔案，當檔案不存在的時候就執行 `go build ...` 指令

## 問題

如果現在存在一個 `build` 檔案， `go build ...` 指令就不會再被執行了

這個情況就需要用到 Phony Targets

## Phony Targets

把 build 設定成 phony 的 prerequisites，如下面:

```makefile
.PHONY: build
build:
	go build -o main main.go
```

執行 `make build`，Make 就不再會檢查檔案，`go build ...` 指令都會正常運作了

這樣設定 Phony Target 還會有兩點好處:
- 避免 target 跟同名檔案衝突
- 改善效能

### 心得

我看著 `.PHONY` 這個東西好幾年了，最近才明白它的做用。

原來說明手冊都有寫，不認真看說明真得很不可取。

### Reference

- [Phony Targets (GNU make)](https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html)
- [What is the purpose of .PHONY in a Makefile? - Stack Overflow](https://stackoverflow.com/questions/2145590/what-is-the-purpose-of-phony-in-a-makefile/2145605)
