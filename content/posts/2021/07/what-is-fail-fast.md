---
title: "什麼是快速失敗 (Fail Fast)"
date: 2021-07-22T01:59:23+08:00
tags: [principle]
---
身為一個軟體工程師，我們通常希望程式正常運作不要有問題，但是在開發過程中一定少不了 debug 跟設計錯誤處理的流程，這時候決定處理錯誤策略，就是一件很重要的事情了。

## 什麼是 Fail Fast?

你可能聽過一種方法：當程式遇到問題時，要設計一些方式去應對問題，試著減輕問題或是解決問題。

而 Fail Fast 的做法不同：當有異常狀況發生時，程式能夠馬上並且明顯地失敗。

> When a problem occurs, it fails immediately and visibly.
>
> -- Jim Shore - Fail Fast

相對於 Fail Fast，那些試著讓程式解決錯誤的方法，往往讓事情變的越複雜，增加排除錯誤的成本。而且讓程式在有風險的狀態下繼續執行工作，可能會讓異常狀況越來越嚴重。

更嚴重的問題，往往會比一開始的問題還要可怕，例如以下情況：
- 資料遺失、資料不一致
- 系統當機後長時間無法回復運作

## Fail Fast 的好處

- 避免錯誤被隱藏或是變成複雜難解的問題
- 早點回饋錯誤，早點排除問題，降低除錯的成本，減少不必要的運算
- 讓錯誤更容易被發現，程式可以更快的成長為穩定的版本

## 怎麼做到 Fail Fast

先來個生活版的 example：出門前先檢查有沒有拿車鑰匙 vs 走到車子旁邊再檢查有沒有拿車鑰匙。

這個差別應該很明顯，提早檢查可以幫自己省下白走一趟路的時間。

### Service Startup

- 在啟動服務時會先檢查過 config, environment variable 是否正確，如果有缺少或是格式錯誤，系統會直接失敗，停止啟動中的服務
- 這樣的設計讓我們清楚的知道發生了問題並且可以快速做處理，可以保證運行中的服務一定是使用正確的設定
- nginx, apache 一些常用的服務都是這樣設計

### RESTful API

- API 如果檢查資料發現有錯誤時，會直接回傳 400 Bad Request 跟錯誤訊息並結束這次的請求
- 提早產生結果讓資訊更單純，而已省下原本要執行任務的運算跟時間

### Class Constructor 

- 利用建構子來規範建立物件的必要資料，並且檢查資料是否符合規則
- 當資料有問題時，就無法建立物件
- 當物件成功建立時，就不用擔心物件包含著無效的資料
- 這樣系統就不會拿著一個有問題的物件繼續工作，能夠避免造成更大的災難

### 其他的 case

- Test-driven development
- Continuous integration

## Summary

多篇文章都有提到 Fail Fast 的做法違反直覺，回想我過去開發程式的過程中也確實如此，一開始會很直接的在 bug 或錯誤的地方增加一些應對的做法。但隨著跟 bug 周旋的次數越多，做法也漸漸的趨向 Fail Fast 了。

原本只是在討論 Code Review 時出現的想法，想要從程式設計的角度研究 Fail Fast 的概念，但是意外發現其實在很多領域跟方法都有 Fail Fast 的概念存在。像是敏捷開發中提到的快速迭代，或是測試驅動開發等等。

## Reference

- https://wiki.c2.com/?FailFast
- https://www.martinfowler.com/ieeeSoftware/failFast.pdf
- [What does the expression &quot;Fail Early&quot; mean, and when would you want to do so? - Stack Overflow](https://stackoverflow.com/questions/2807241/what-does-the-expression-fail-early-mean-and-when-would-you-want-to-do-so)
- [The Fail-Fast Principle in Software Development - DZone Agile](https://dzone.com/articles/fail-fast-principle-in-software-development)
- [About the Fail Fast principle - DEV Community](https://dev.to/ysflghou/about-the-fail-fast-principle-4kj2)
- [Fail Fast Principle Software Development | Level Up Coding](https://levelup.gitconnected.com/the-power-of-failing-fast-2a5847e06f7)
- [搞笑談軟工: Fail Fast不是這樣用的吧？！](http://teddy-chen-tw.blogspot.com/2017/03/fail-faster.html)
