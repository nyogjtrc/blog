---
title: "utterances: 使用 github issue 做部落格的留言系統"
date: 2021-03-20T01:20:32+08:00
tags: [blog, github]
---

說到留言系統，過去最常看到的大概是 Disqus

但是實際使用過會發現 Disqus 的檔案太肥大，會拉長網站的載入速度，所以在我把部落格移到 github 上面的時候，就完全不想要整合留言系統

不知道從什麼時候開始，看到越來越多人試著把 github issue 當成網站的留言系統，這個組合真的是太棒了

## utterances

最後決定使用 [utterances][u]，選擇的原因大概有以下幾點:

- 設定方式相對容易
- 個人很喜歡 issue 系統的風格
- 使用上相當輕量
- 沒有追蹤用戶隱私的問題

## 設定 utterances

在 [utterances][u] 的網頁上有很清楚的設定說明

1. 選定要放留言的 repo
2. 安裝 [utterances app](https://github.com/apps/utterances) 在選定的 repo
3. 選擇留言的 issue title 的格式
4. 選擇留言要設定的 issue label
5. 選擇 css 主題
6. 拿到一個 script tag
    ```html
    <script src="https://utteranc.es/client.js"
            repo="[ENTER REPO HERE]"
            issue-term="pathname"
            theme="github-light"
            crossorigin="anonymous"
            async>
    </script>
    ```
7. 把這個 tag 放到部落格裡適合的位置就完成了

## 訪客留言方式

- 訪客要有 Github 帳號
- 經由 Github OAuth 授權給 utterances
- 開始留言
  ![](/posts/2021/03/utterances-comment.png)

## Reference

- [utterances][u]
- [Utterances 免費開源、無廣告、無追蹤的網站留言系統 | jkgtw's blog ](https://www.jkg.tw/p3350/)
- [Using GitHub Issues for Blog Comments](https://danyow.net/using-github-issues-for-blog-comments/)

[u]: https://utteranc.es/
