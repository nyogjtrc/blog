---
title: "使用 Github Actions 測試 Go"
date: 2023-01-30T22:40:56+08:00
tags: [github ci]
---

Github Actions 是 Github 推出的 CI/CD 工具，釋出有一陣子了，平常工作上不常用 Github，所以一直沒有機會試試看。

最近回頭更新放在 Github 上的 Golang 程式，就順手的放上 Github Actions 幫忙跑一下測試。

## 認識 Workflow

我們可以很簡單的從官方文件 [GitHub Actions Documentation](https://docs.github.com/en/actions) 了解如何在 repository 加入 workflow。

workflow 都會是 YAML 檔案，一律放在 `.github/workflows` 資料夾。Github 在 https://github.com/actions/starter-workflows 提供了很多的基礎的 workflow 寫法，我們就先從這裡開始認識。

檔案: https://github.com/actions/starter-workflows/blob/main/ci/go.yml

```yml
name: Go

on:
  push:
    branches: [ $default-branch ]
  pull_request:
    branches: [ $default-branch ]

jobs:

  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3

    - name: Set up Go
      uses: actions/setup-go@v3
      with:
        go-version: 1.19

    - name: Build
      run: go build -v ./...

    - name: Test
      run: go test -v ./...
```

- name: workflow 的名稱，會顯示在 `Actions` 頁籤
- on: 設定觸發 workflow 的事件
- jobs: 設定一個到多個工作，每個工作預設會是平行處理的
- runs-on: 決定 job 的運行環境
- steps: 設定要執行的任務，可以是單純的指令或是包裝好的 action

## 修改自己的 Workflow

再來看看我修改好的 workflow 檔案

檔案: https://github.com/nyogjtrc/deciduous/blob/master/.github/workflows/go.yml
```yml
name: Go

on: [push]

jobs:

  lint:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3

    - name: Set up Go
      uses: actions/setup-go@v3
      with:
        go-version: 1.17

    - name: golangci-lint
      uses: golangci/golangci-lint-action@v3

  test:
    needs: lint
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3

    - name: Set up Go
      uses: actions/setup-go@v3
      with:
        go-version: 1.17

    - name: Build
      run: make build

    - name: Test with coverage
      run: make coverage
```

首先是 on 設定成 push 就觸發 workflow

jobs 加入 **lint** 跟 **test** 兩個 job, **test** 設定 `needs: lint` 等 **lint** 成功才執行

lint job 依序執行:
- 從 repository 中 checkout 程式碼
- 設定環境到指定的 go 1.17
- 執行 golangci-lint

test job 依序執行:
- 從 repository 中 checkout 程式碼
- 設定環境到指定的 go 1.17
- 執行寫在 **Makefile** 的 `go build` 指令
- 執行寫在 **Makefile** 的 `go test` 指令
