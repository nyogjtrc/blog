---
title: "CI vs Hooks 自動化工具比較"
date: 2020-10-18T23:54:20+08:00
tags: [ci, git]
---

前陣子在一場討論中，聊到一些能夠觸發測試的自動化工具 (Gitlab CI, Phabricator Arcanist, Git hooks)

討論的過程中，發現有些人會認為只要能夠**自動執行**測試，效果上都是一樣的。但實際上，每個工具想要解決的問題並不一樣。

先看看這幾個工具:

Git hooks
- Git 本身的機制
- 在 commit, push 等等特定的指令操作之前或之後觸發 scripts
- 用 script 連動 lint 跟 unit test 工具的話，能夠確保程式碼的品質
- 觸發的工作會在「工程師的電腦」上執行

Phabricator Arcanist
- Phabricator 的 cli 工具
- 整合 lint 跟 unit test 工具，在上傳程式碼之前觸發
- 觸發的工作會在「工程師的電腦」上執行

CI (Continuous Integration)，中文：持續整合
- CI 自動化工具有多種選擇: Gitlab Runner, CircleCI, GitHub Actions ...etc
- 在每次 push 程式碼到 git hosting server 之後觸發一系列的工作以測試跟驗證程式碼，也可以設定成定時觸發
- 觸發的工作會在「CI 服務」上執行


這幾個工具都可以整合 unit test 跟 lint 等工具，在指定的時間自動執行，確保程式碼的品質。

當你只是一個人獨立開發程式，需要一個自動化工具，相信都是不錯的選擇。

但是當開發者不止一個人，又或者是遇到龐大的系統時，情況可能會有一點不一樣了。

## 執行環境一致性

- 要確保團隊裡每個人的電腦環境一模一樣是不可能的
- CI 服務能夠確保每次處理的工作內容跟環境都是相同的
- 能夠保證你所看到「通過驗證」的訊息確實是在你所預期的環境下執行你所預期的工作內容

## 小型輕量的系統 vs 大型復雜的系統

- 執行測試所需要的「時間」跟「機器資源」會隨著系統的復雜度提高而增加
- 工程師不可能每次都要等到測試全部跑完，才繼續工作
- 把工作交給 CI 服務去消化，不佔用開發者的電腦，也不會卡住工作的進行
- 隨著系統成長，我們只要建構出適合的 CI 服務，開發團隊就能夠繼續運作

## 總結

以現在大家都在討論「敏捷開發」跟「DevOps」的驅勢之下，CI 服務基本上是必備的工具。

部署好的 CI 服務，可以讓開發團隊更順暢的迭代，工程師能夠更舒服的寫程式。

## Reference
- https://stackoverflow.com/questions/49994976/why-test-in-continuous-integration-if-you-can-test-on-pre-commit-and-pre-push-gi
- https://devops.stackexchange.com/questions/8447/ci-platforms-versus-simple-git-hooks
- https://git-scm.com/book/zh-tw/v2/Customizing-Git-Git-Hooks
- https://secure.phabricator.com/book/phabricator
- https://en.wikipedia.org/wiki/Continuous_integration
