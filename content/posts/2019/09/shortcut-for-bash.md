---
title: "Bash 常用快捷鍵"
date: 2019-09-15T13:15:40+08:00
tags: [terminal, bash]
---

記錄一些比較常用/實用(可能)的快捷鍵

## 控制
- **Ctrl+C**: 中斷正在執行的程式
- **Ctrl+D**: 結束 shell (同 exit)
- **Ctrl+Z**: 暫停正在執行的程式，放入背景 (使用 fg 可以叫回來)
- **Ctrl+X Ctrl+E**: 使用 vim 編輯 script 並一次執行

## 移動
- **Ctrl+A**: 到此行最前面 (同 Home 鍵)
- **Ctrl+E**: 到此行最後面 (同 End 鍵)
- **Alt+B**: 前進一個字元
- **Alt+F**: 後退一個字元
- **Ctrl+B**: 前進一格
- **Ctrl+F**: 後退一格

## 刪除
- **Ctrl+H**: 移除前一個字元 (同 Backspace 鍵)
- **Ctrl+D**: 移除後一個字元 (同 Delete 鍵)
- **Ctrl+U**: 移除游標之前的所有文字
- **Ctrl+K**: 移除游標之後的所有文字

## 歷史指令
- **Ctrl+P**: 上一個指令
- **Ctrl+N**: 下一個指令
- **Ctrl+R**: 搜尋指令
- **Ctrl+R**: 上一個
- **Ctrl+Shift+R**: 下一個
- **Ctrl+G**: 取消搜尋

## 畫面
- **Ctrl+L**: 清空畫面 (同 clear)
- **Ctrl+S**: 凍結畫面輸出
- **Ctrl+Q**: 回復畫面輸出

---

### Reference
- [Bash Shell 快速鍵 | Tsung's Blog](https://blog.longwin.com.tw/2006/09/bash_hot_key_2006/)
- [Shortcuts to move faster in Bash command line - teohm.dev](http://teohm.github.io/blog/2012/01/04/shortcuts-to-move-faster-in-bash-command-line/)
- [The Best Keyboard Shortcuts for Bash](https://www.howtogeek.com/howto/ubuntu/keyboard-shortcuts-for-bash-command-shell-for-ubuntu-debian-suse-redhat-linux-etc/)

