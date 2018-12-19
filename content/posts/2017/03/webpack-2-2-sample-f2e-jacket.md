---
title: 'Webpack 2.2 Sample - f2e-jacket'
date: 2017-03-31T14:15:00+08:00
tags: [webpack, react]
---
不小心看到 webpack 2.2 發佈，就來小玩一下，用 webpack 打包一個 front end 開發工具

專案在此: f2e-jacket https://github.com/nyogjtrc/f2e-jacket

使用方法:

```bash
$ git clone git@github.com:nyogjtrc/f2e-jacket.git
$ cd f2e-jacket/
$ yarn
$ yarn start
```

在製作的一開始，我以為我只要認識一下 webpack 的新版用法就好。沒想到當我要把 react 加進去的時候，事情就變的有點精彩了。

離我上次建置環境的時候，react 的大版本號一樣是 15。嗯，這個還好。react-router 在上次我看的時候是 2.x.x，而現在是 4.0.0，跳了兩個版本，寫法變的完全不一樣，全部重新認識。好在最後放 semantic-ui 的時候沒有遇到什麼奇怪的問題。

## What's inside

目前在 v0.1.1 裡面包括 react, react-router, semantic-ui 這幾個 library

在建立這個工具的途中，發現 facebook 有製作一個 react 專用的工具 https://github.com/facebookincubator/create-react-app
也是可以直接拿來用的…

### Reference
https://github.com/nyogjtrc/f2e-jacket
https://webpack.js.org/
https://github.com/facebookincubator/create-react-app
