---
title: "Vim - Global Command g"
date: 2017-03-12T04:56:43+08:00
tags: [vim]
---
最近在使用 vim 處理文字時，想要刪掉特定的幾行，試了幾個方法後，發現一個好像很方便的 :g 指令

global command :g
```vim
:[range]g/pattern/cmd
```

針對特別的 *range* (預設是整個檔案)，找出符合 *pattern* 的每一行，執行 *cmd* 的處理

## Example

刪掉符合的每一行
```vim
:g/pattern/d
```

刪掉「不」符合的每一行
```vim
:g!/pattern/d
:v/pattern/d
```

刪掉所有的空白行
```vim
:g/^\s*$/d
```

符合的每一行移到檔案結尾
```vim
:g/pattern/m$
```

反轉整份文件
```vim
:g/^/m0
```

在符合 pattern 的每一行行尾加上「mytext」
```vim
:g/pattern/s/$/mytext
```

### Reference
http://vim.wikia.com/wiki/Power_of_g
