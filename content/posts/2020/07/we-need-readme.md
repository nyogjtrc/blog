---
title: "我們需要 Readme"
date: 2020-07-21T02:23:10+08:00
tags: [readme]
---

## 問題情境

- 拿到一份程式碼，但是不知道可以做什麼，不知道怎麼運行它
- 一個宣稱幫你解決很多麻煩的工具，但是沒有說明清楚怎麼使用
- 想要參與專案的開發，但是不知道如何設置開發環境

當你遇到這些問題時，你會怎麼解決問題？

同時換個角度，當一堆人來問你問題的時候呢？

## 我們需要 Readme

Readme 可以：

- 介紹並說明一個專案的概況，讓人看完可以對專案有基本的認識
- 展示專案是如何運作的
- Readme 是打開一個專案最近會看的檔案
- 用 Markdown 語法編輯，檔案名稱全大寫的英文  `README.md`

## Readme 需要的元件

### 標題 (Title)

給專案取個好名字

### 簡介 (Description)

說明專案的用途、目的，以及一些背景資訊等，要讓人可以快速了解這個專案

### 徽章 (Badges)

一個小小的圖片，讓你可以快速的知道 CI/CD 狀態、程式覆蓋率之類的資訊

可以用 [Shields.io](https://shields.io/) 的服務來產生圖片

### 安裝 (Installation)

說明這個專案的**系統需求** (Requirments)，以及如何**設定**

### 使用 (Usage)

如何使用這個專案的程式。假如是套件，那麼你可能會附上一段**程式碼範例**。假設是工具，那可能會放上**指令**跟**參數**的說明

### 開發 (Development)

如果要參與開發這個專案，要依照哪樣的程式碼風格 (coding style)，要如何「跑測試 (run test)」

## 有很棒的 README 的專案

- https://github.com/jakubroztocil/httpie
- https://github.com/Redocly/redoc
- https://github.com/gin-gonic/gin

---

### Reference

- [Make a README](https://www.makeareadme.com/)
- [How to write a good README for your GitHub project?](https://bulldogjob.com/news/449-how-to-write-a-good-readme-for-your-github-project)
- https://github.com/matiassingers/awesome-readme
- [A sample README for all your GitHub projects. · GitHub](https://gist.github.com/fvcproductions/1bfc2d4aecb01a834b46)
