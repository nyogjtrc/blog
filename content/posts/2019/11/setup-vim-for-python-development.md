---
title: "配置開發 Python 的 vim 環境"
date: 2019-11-24T20:35:27+08:00
tags: [vim, python]
---

最近有機會寫一下 Python 就順便來改造一下 vim

## Autocompletion

- https://github.com/davidhalter/jedi
- https://github.com/deoplete-plugins/deoplete-jedi

jedi 這個 library 提供編輯器對 python 程式碼的 autocompletion 跟 goto 的功能

我的 vim 是使用 deoplete 這套 autocompletion 工具，則是使用 deoplete-jedi

### 安裝

```
$ pip install jedi
```
### vimrc

使用 Plug 或其他 vim 套件管理安裝

```vim
Plug 'deoplete-plugins/deoplete-jedi', { 'for': 'python' }
```

截圖:

![](/posts/2019/11/Screenshot_from_2019-11-24-21-20-37.png)

## Formatter & Linter

- https://github.com/google/yapf
- https://github.com/timothycrosley/isort
- http://flake8.pycqa.org/

yapf google 提供的 python code formatter

isort 則是會幫忙整理 import 的順序跟組合

flake8 檢查 python 的 coding style 是否依照 pep8

以上三個工具都可以跟 ale 整合，所以 vim 中只要對 ale 安裝跟設定就好

### 安裝

```
$ pip install yapf isort flake8
```

### vimrc

ale 的 python linter 預設有 flake8，所以這邊就不多做設定了

```vim
Plug 'dense-analysis/ale'

let g:ale_fixers = {
\   'python': ['yapf', 'isort'],
\ }
```

截圖:

![](/posts/2019/11/Screenshot_from_2019-11-24_23-01-01.png)


## 總結

ale 意外的強大，整合了多數的 Linter 跟 Fixer

