---
title: "Cohesion and Coupling"
date: 2020-06-01T01:12:19+08:00
tags: [software development]
---

想要評估一份程式碼是不是好的設計，不會是比較資深的工程師說了就算數

其中一個方法就是從內聚跟耦合的程度來評估

## Cohesion (內聚)

一個模組內的不同功能的相關程度

例如，當處理某個任務的程式跟資料都在同一個模組內，表示這個模組有很高的內聚力

## Coupling (耦合)

不同模組之間的關連或依賴程度

例如，當兩個模組都使用到同一個全域變數時，這兩個模組就彼此耦合

## 好的設計?

那麼，好的軟體設計? 好維護的程式?

`High Cohesion, Low Coupling (高內聚，低耦合)`

## 好處

- 模組「專注」在同一件事情上，提高模組被「重複使用」的機會
- 增加程式的「可讀性」，程式更容易被閱讀被理解
- 不用怕修改程式時會引發「漣漪效應」，甚至是「蝴蝶效應」

---

#### Reference

- [搞笑談軟工: 亂談軟體設計（1）：Cohesion and Coupling](http://teddy-chen-tw.blogspot.com/2011/12/1.html)
- [軟體工程(Software Engineering;SE)](https://irw.ncut.edu.tw/peterju/se.html)
- [oop - Difference Between Cohesion and Coupling - Stack Overflow](https://stackoverflowcom/questions/3085285/difference-between-cohesion-and-coupling)
