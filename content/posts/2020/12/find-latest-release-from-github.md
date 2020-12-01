---
title: "找到 github 上面專案的最新版本"
date: 2020-12-01T22:55:19+08:00
tags: [github, bash]
---

使用 github api 就可以查到最新的版本

需要的 command:
- curl
- jq

```bash
latest_release() {
    repo_name=$1
    curl --silent \
	    https://api.github.com/repos/$repo_name/releases/latest | \
        jq -r '.tag_name'
}
```

執行結果，以 tmux 當範例
```bash
$ latest_release tmux/tmux
3.1c
```


### Reference

- [Shell - Get latest release from GitHub](https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c)
