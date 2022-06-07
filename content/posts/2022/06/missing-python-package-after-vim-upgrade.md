---
title: "Vim 更新後缺少 Python 套件 pynvim neovim"
date: 2022-06-08T01:12:00+08:00
tags: [vim]
---

久違的更新一下 vim
```
$ brew upgrade vim
```

打開 vim 馬上出現一堆錯誤訊息
```
[vim-hug-neovim-rpc] failed executing: pythonx import [pynvim|neovim]
[vim-hug-neovim-rpc] Vim(pythonx):ModuleNotFoundError: No module named 'neovim'
E605: Exception not caught: [vim-hug-neovim-rpc] requires one of `:pythonx import [pynvim|neovim]` command to work
```
這些錯誤好熟悉，似乎是 vim 又找不到 python 的套件了


先檢查 vim 版本跟相依套件
```
$ vim --version
VIM - Vi IMproved 8.2 (2019 Dec 12, compiled Jun 01 2022 14:23:13)
macOS version - x86_64
Included patches: 1-5050
Compiled by Homebrew
Huge version without GUI.  Features included (+) or not (-):

...
+python3

...

Compilation: clang -c -I. ... -L/usr/local/opt/python@3.10/Frameworks/Python.framework/Versions/3.10/lib/python3.10/config-3.10-darwin -lpython3.10
```

vim 確實有支援 python3，但居然是 Python 3.10。更新之前的 Python 套件是裝在 Python 3.9 裡，這樣要再重新安裝需要的 Python 套件了。

檢查系統預設的 Python 3 版本
```
python3 --version
Python 3.9.13
```

預設依舊是 Python 3.9，所以直接使用 `pip3 install` 安裝的套件 vim 是讀取不到的。

用 `brew info` 查詢 Python 3.10 的設定
```
$ brew info python@3.10
python@3.10: stable 3.10.4 (bottled) [keg-only]
...
You can install Python packages with
  /usr/local/opt/python@3.10/bin/pip3 install <package>
They will install into the site-package directory
  /usr/local/lib/python3.10/site-packages
...
```

說明直接寫了如果想要安裝套件可以使用的指令，只要直接使用 Python 3.10 的 pip3 執行檔下指令安裝即可。

依照說明下指令安裝缺少的 `pynvim` 跟 `neovim`
```
/usr/local/opt/python@3.10/bin/pip3 install pynvim neovim
```

我有把安裝 vim 寫成 Ansible playbook，
可以在 pip module 加上 executable 參數指定使用 Python 3.10 的 pip3 執行檔，就可以做到一樣的事情。

```
- name: Install python library for vim
  pip:
    executable: /usr/local/opt/python@3.10/bin/pip3
    name:
      - pynvim
      - neovim
```

安裝完畢後 vim 已可以正常工作

## Reference

- https://docs.ansible.com/ansible/latest/collections/ansible/builtin/pip_module.html
- https://github.com/roxma/vim-hug-neovim-rpc
