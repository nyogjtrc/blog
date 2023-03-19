---
title: "將 Git 預設分支從 Master 改成 Main"
date: 2023-03-19T21:39:43+08:00
tags: [git]
---
## 歷史

2020 年 6 月 git 發佈了一篇聲明，說明了 git 預設的分支 master 是有具有歧視性的單字，接下來會加入一些機制允許使用者設定預設分支名稱，。之後 git 在 2.28.0 加入了 `init.defaultBranch` 選項，許多的公司跟社群都陸繼加入這項行動。像是 `Github` 與 `Gitlab`，都將系統的預設分支名稱從 `master` 改成 `main`

## init.defaultBranch

`git init` 會依照 `init.defaultBranch` 的設定名稱建立預設的分支，如果沒有設定 `init.defaultBranch` 預設值是 `master`

```
$ git config --global init.defaultBranch main
```

## 修改已存在的專案預設分支名稱

如果想要將以前建立的專案的 `master` 分支改名成 `main` 很簡單。指令如下:
```
$ git branch -m master main
```

如果要連同 remote 都修改，就要再執行以下指令:
```
$ git push -u origin main
$ git push origin --delete master
```

## Reference

- https://github.com/github/renaming
- https://about.gitlab.com/blog/2021/03/10/new-git-default-branch-name/
- [Regarding Git and Branch Naming - Software Freedom Conservancy](https://sfconservancy.org/news/2020/jun/23/gitbranchname/)
- https://github.blog/2020-07-27-highlights-from-git-2-28/
- https://blog.longwin.com.tw/2020/10/github-git-default-branch-main-replace-master-2020/
