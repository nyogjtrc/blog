---
title: "Git Pull Warning and Foxtrot Merge"
date: 2020-12-01T02:25:33+08:00
tags: [git]
---

最近把 git 升級到 2.27 版

```bash
$ git version
git version 2.27.0
```

執行 git pull 指令時，會跳出一篇警告

```bash
$ git pull
warning: Pulling without specifying how to reconcile divergent branches is
discouraged. You can squelch this message by running one of the following
commands sometime before your next pull:

  git config pull.rebase false  # merge (the default strategy)
  git config pull.rebase true   # rebase
  git config pull.ff only       # fast-forward only

You can replace "git config" with "git config --global" to set a default
preference for all repositories. You can also pass --rebase, --no-rebase,
or --ff-only on the command line to override the configured default per
invocation.
```

大致上是要你決定在 pull 遇到分支衝突的處理方式。

## 先說結論

強烈建議 pull 行為設定成 `fast-forward only`，這樣的設定可以減少不必要的記錄錯亂以及糟糕的 git 使用體驗。

設定指令如下:

```
$ git config --global pull.ff only
```

## 預設方式: merge

git 裡栽預設的行為是 merge。以下舉列一個情境說明

一開始的 master 在 B commit，
當 local 增加了一些 commit (E, F, G)，
remote 的 master 也增加一些 commit (C, D)，
這時兩邊的 master 就長得不一樣。

```
      E---F---G master
     /
A---B---C---D origin/master
    ^
    old master
```

為了更新 Repository 的資料進行後續的工作，
這時候你執行 git pull，
pull 指令會把 origin/master 合併到 master 上，產生一個 merge commit H。

```
      E---F---G---H master
     /           /
A---B---C-------D origin/master
```

這時候你可能還沒有發現有什麼問題，最後把 master 推到 remote，
執行 `git push`，這時 Repository 的記錄會變成以下情況

```
      C-----------D
     /             \
A---B---E---F---G---H master, origin/master
```

發生了什麼事? 這邊的操作產生了 `Foxtrot Merge`


## Foxtrot Merge 的問題

- 改變 origin/master 的 first parent 記錄
- 上面的例子中，原本應該是 origin/master 的主要 commit C 跟 D 變成從其他分支合併進來的 commit
- 這樣的變化會使你在回顧歷史記錄時很錯亂，有一種 commit 被亂改的感覺

這個變化會影響:
- 使用波浪符號 (ex. HEAD~) 對應的 commit
- 要 revert merge commit 時，要選擇的 parent number
- git log --graph 的排列
- git log --first-parent 顯示的 commit

## fast forward only 方式

同樣的情況下使用 fast forward only 的方式會收到一個錯誤

```bash
$ git pull --ff-only
fatal: Not possible to fast-forward, aborting.
```

接下來依照情況不同選擇處理方式，可能會是:

- 把 local 增加的 commit rebase 到 origin/master
- 先 reset merge commit，重新 pull master，再執行原本的 merge 動作

## 結論

- 如果你不是 Repository 的維護者，你可能比較不會遇到這樣的事情
- 如果你完全沒在看記錄的話當然是沒差，最終的程式碼都會是一樣的
- 在使用一些 git 指令出來的結果會有差異
- 當你在看這一些歷史記錄時會錯亂，分不清上一個 commit 到底是哪一個

### Reference

- https://www.reddit.com/r/git/comments/h7kv0y/git_2270_starts_yelling_during_pull/
- https://blog.developer.atlassian.com/stop-foxtrots-now/
- https://blog.sffc.xyz/post/185195398930/why-you-should-use-git-pull-ff-only-git-is-a
- https://stackoverflow.com/questions/57090638/foxtrot-merge-how-to-solve-it
