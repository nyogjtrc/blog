---
title: "四個「簡單設計」規則 (Xp Simplicity Rules)"
date: 2020-10-25T00:28:29+08:00
tags: [programming]
---

一直想找看看有沒有更加簡單好懂，更為基本的原則，當做程式設計時核心理念。

看過 SOLID，讀過 Clean Code，在實戰中不斷的練習。研究設計模式 (Design Pattern)，但是複雜解決方案不一定能夠派上用場。

看到 Kent Beck 提出四個「簡單設計 (Simple Design)」規則，心中覺得這個就是我最近在尋找的東西。

## Kent Beck 的四個「簡單設計 (Simple Design)」規則

- Runs all the tests
    - 通過所有的測試
- Has no duplicated logic. Be wary of hidden duplication like parallel class hierarchies
    - 沒有重複的邏輯，注意隱藏的重複程式例如併行的類別階層結構
- States every intention important to the programmer
    - 對程式設計師說明每個重要的意圖
- Has the fewest possible classes and methods
    - 盡可能使用最少量的類別跟方法

## Martin Fowler 的四個「簡單設計」規則

Martin Fowler 以更加簡潔版本來表達這四個規則

- Passes the test: 通過所有測試
- Reveals intention: 程式碼本身要展現其意圖
- No duplication: 沒有重複性的程式
- Fewest elements: 使用最少的元素

除了這兩為大師級的分享之外，還有許多討論跟不同版本的描述

首先這四個原則是有優先順序的!! 但是不管是哪個版本，第一個都會是「通過所有測試」

### Passes the test: 通過所有測試

Extreme Programming 把「測試」的地位變成軟體開發最首要的行為。讓「測試」告訴你有沒有完成目標，並確保程式如預期工作。

如果一個系統不能正常運作或是無法確定它能不能正常運作，會降低它的價值增加工程師的壓力。

### Reveals intention: 程式碼本身要展現其意圖

程式碼是給人看的，好的程式碼是要在閱讀的時候覺得好讀好懂。
要容易理解程式碼的關鍵是在程式碼本身要展現出它的意圖，如同 Self Documenting Code，程式碼本身就是自己最好的文件。

### No duplication: 沒有重複性的程式

類似的概念有: DRY (Don't Repeat Yourself), Once and only once, SPOT (Single Point Of Truth)，都是在說相同的程式碼只會出現一次。

除了程式碼，其他不管是概念還是功能等等重複，也都需要被避免。而練習減少重複程式更是產生優良設計的好方法。

### Fewest elements: 使用最少的元素

類似的概念: YAGNI (You aren't gonna need it)。

有一些設計建議會要求在現有架構上增加一些元素，想要提高對未來需求的靈活性，但是額外的複雜性並不一定能夠派上用場，還會讓系統難以修改。
因此只加入需要的程式，不做多餘的設計，才是好的設計。


## 總結

Kent Beck 提出的「簡單設計」原則，簡單好記，適用在各種情況，又足夠影響我們的程式設計思緒。

---

### Reference

- [BeckDesignRules - Martin Fowler](https://martinfowler.com/bliki/BeckDesignRules.html)
- [Xp Simplicity Rules](http://wiki.c2.com/?XpSimplicityRules)
- [Kent Beck 的四個簡單程式設計原則 – ihower](https://ihower.tw/blog/archives/7181)
- [搞笑談軟工: 摩登開發人員](http://teddy-chen-tw.blogspot.com/2016/09/blog-post_12.html)
- [The Four Elements of Simple Design](https://blog.jbrains.ca/permalink/the-four-elements-of-simple-design)
