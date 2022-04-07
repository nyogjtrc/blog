---
title: "Event Storming 的便利貼"
date: 2022-04-07T20:57:05+08:00
tags: [event storming]
---

Event Stroming 是一個可以用來讓團隊了解商業邏輯並設計軟體的工具，最終用大量的便利貼來呈現結果

## The picture that explains everything

![The picture that explains everything.jpg](/posts/2022/04/The-picture-that-explains-everything.jpg)
(from Alberto Brandolini’s "Introducing Event Storming")

這篇整理一下便利貼的用途說明

### Domain Events 領域事件
- 橘色便利貼
- 使用過去式動詞
- 跟領域專家相關

領域事件從哪邊來？
- 可能是「使用者」觸發了一個「指令」
- 可能是「外部系統」觸發「領域事件」
- 可能是時間流動的結果
- 可能是一個事件觸發了另一個事件

### Questions / Hot Spots
- 紅色
- 關鍵問題
- 可能代表問題、風險、需要進一步探索的區域、選擇點
- 我們還沒有足夠的資訊
- 有關鍵要求的系統部份

### External Systems 外部系統
- 大張粉紅色便利貼
- 外部組織、服務、其他線上程式

### Commands
- 藍色便利貼
- 使用者的意圖、行動、決策

### Actors 
- 小張黃色便利貼
- 使用者

### Read Models
- 綠色便利貼
- 使用者為了做決策所使用的資料

### Policy
- 淡紫色便利貼
- 每當…時
- 有時候是自動化
- 有時候是希望提醒人要記得的事情

### Aggregates
- 淡黃色便利貼
- 來自 Domain-Driven Design 的重要概念
- 依職責幫 Command 進行分組
- 像是小型的狀態機

## 小結
- Event Storming 可以讓工程師跟領域專家一起來找出領域的核心商業邏輯
- 從全局看到細節: Big Picture > Process Modelling > Software Design
- 不在意精確的定義，進行的這場談話比使用精確的符號更為重要

### Reference

- https://leanpub.com/introducing_eventstorming
- http://teddy-chen-tw.blogspot.com/2020/12/13event-storming.html
