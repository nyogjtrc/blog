---
title: "用 Hugo 發佈部落格"
date: 2017-09-24T13:36:35+08:00
tags: [hugo, github, golang, blog]
---

Hugo 是用 Go 開發的靜態網站產生器

我為了把 blog 文章改放到 Github Page 上，一開始是想到 Jekyll 這個超熱門的工具

稍微研究一下後，發現是用 Ruby 寫的，讓我不太想用

最後是發現了 Hugo，評估過上手難易度後，決定就用他來試試了

# 安裝

go get 安裝法
```shell
go get -v github.com/gohugoio/hugo
```

# 建立網站

建立一個名為 blog 的網站

```shell
hugo new site blog
```

# config 檔

預設是產生 `config.toml`，還支援 yaml, json 格式

我決定要使用 yaml 格式，所以要自己修改一下

# 選網站主題

在 https://themes.gohugo.io/ 上有超過百個主題可以選擇

把 theme 加入 config 檔，再加上 theme 所需要的設定

```yaml
theme: hugo-dusk

menu:
     main:
...
```

# 建立新文章

建立新的文章前要先來安排一下檔案存放的結構，我想要依照年份跟月份來分資料夾放

產生新文章的 command 就會如下

```shell
hugo new posts/2017/09/the-first-hugo-post.md
```

接下來就是開啟妳的編輯器來寫文章

# 用內建的 Web Server 檢查成品

多加個 -D 的參數 render 草稿:

```shell
hugo server -D
```

# 產出靜態檔案

```shell
hugo
```

指令就只有上面這樣的簡單，產出的靜態檔案預設會在 public 資料夾下

想要改位置就是設是 config

```yaml
publishDir: my-public-project
```

# 發佈

要使用 github page 的方法很多，我看了不少人都是將 public 資料夾切 subtree，或是用 submodule，但是我覺得都太麻煩了

把 `publishDir` 指到其他的 git repository

github page 設定使用 master branch

操作只要 git commit, git push 這些基本的指令就可以了

## Reference

- [Hugo](https://gohugo.io/)
