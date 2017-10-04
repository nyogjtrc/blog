---
title: "交換 Left Ctrl 跟 CapsLock 的位置，救救你的左手小指"
date: 2017-10-04T18:11:31+08:00
tags: [Ctrl, CapsLock]
---

身為 vi 跟 terminal 的主要使用者，Ctrl 是重要的夥伴
要提高 Ctrl 的地位，減輕左手小指的負擔

ps. 以前的鍵盤配置，Ctrl 在 a 的左邊

# Ubuntu 16.04

安裝 gnome-tweak-tool
```
$ sudo apt install gnome-tweak-tool
```

* 開啟 gnome-tweak-tool
* 選單 Typing -> Ctrl key position
* 選擇 Swap Ctrl and Caps Lock

# Mac

* 開啟 System Preferences
* 選 Keyboard -> Modifier Keys
* Ctrl 換 CapsLock, CapsLock 換 Ctrl

# Windows 7

下載 SharpKeys

* 開啟 SharpKeys
* 按 "Add"
* 點 "Form key" 的 "Type Key"，再按下 CapsLock
* 點 "To key" 的 "Type Key"，再按下 Left Ctrl
* 按 "Add"
* 點 "Form key" 的 "Type Key"，再按下 Left Ctrl
* 點 "To key" 的 "Type Key"，再按下 CapsLock
* 點 "Write to Registry"
* 重開機…

# 初期使用心得

一開始會不習慣，覺得有一些組合鍵不好按，或是一直按錯
會覺得小指無力一直按，原本的位置還有大拇指可以幫一下忙

# 另一個鍵盤設定想法

對習慣使用 Shift 的人，沒有 CapsLock 好像沒差
讓鍵盤上有三個 Ctrl 也是一個不錯的選擇

## Reference

* [keymap - Swap Control and Caps Lock on Windows 7 - Super User](https://superuser.com/questions/292724/swap-control-and-caps-lock-on-windows-7)
* https://github.com/randyrants/sharpkeys
* [keyboard - How do I remap the Caps Lock and Ctrl keys? - Ask Ubuntu](https://askubuntu.com/questions/33774/how-do-i-remap-the-caps-lock-and-ctrl-keys)
