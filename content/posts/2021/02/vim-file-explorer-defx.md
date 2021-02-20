---
title: "Vim File Explorer - Defx"
date: 2021-02-21T01:52:30+08:00
tags: [vim]
---

原本的 vim file explorer 是用 NERDTree，最近發現 vim 大師 Shougo 有推出 [Defx][defx]，所以就來試試新工具

[Defx][defx] 沒有預設的快捷鍵，需要自己做大量設定。一開始我把快捷鍵設定成跟 NERDTree 很相似，但是怎麼試都不太順手，就不再使用過去的習慣了。

目前還要花點時間熟悉跟調整。

除了 [Defx][defx] 本身之外，我還多安裝了 [defx-git][git] 跟 [defx-icons][icons]
- defx-git: 顯示 git status
- defx-icons: 顯示檔案 icon，需要 Nerd font

## 安裝

```vim
Plug 'Shougo/defx.nvim'
Plug 'kristijanhusak/defx-git'
Plug 'kristijanhusak/defx-icons'
```

## 設定

開啟 defx 快捷鍵: <leader>e

```
nnoremap <silent> <leader>e :<C-U>Defx<CR>
```

顯示設定
- 加入 git 跟 icons 的顯示
- 把一些 icon 換成自己喜歡的

```vim
call defx#custom#option('_', {
    \ 'buffer_name': 'tabfx',
    \ 'listed': 1,
    \ 'show_ignored_files': 1,
    \ 'resume': 1,
    \ 'columns': 'indent:mark:icon:icons:filename:git:size',
    \ })

call defx#custom#column('icon', {
    \ 'directory_icon': '▸',
    \ 'opened_icon': '▾',
    \ 'root_icon': '+',
    \ })

call defx#custom#column('mark', {
    \ 'readonly_icon': '✗',
    \ 'selected_icon': '✓',
    \ })
```

在 Defx 內的快捷鍵

```vim
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
    " Define mappings
    nnoremap <silent><buffer><expr> <CR>
        \ defx#do_action('open')
    nnoremap <silent><buffer><expr> c
        \ defx#do_action('copy')
    nnoremap <silent><buffer><expr> m
        \ defx#do_action('move')
    nnoremap <silent><buffer><expr> p
        \ defx#do_action('paste')
    nnoremap <silent><buffer><expr> l
        \ defx#is_directory() ? defx#do_action('open') : 0
    nnoremap <silent><buffer><expr> E
        \ defx#do_action('open', 'vsplit')
    nnoremap <silent><buffer><expr> P
        \ defx#do_action('preview')
    nnoremap <silent><buffer><expr> o
        \ defx#do_action('open_tree', 'toggle')
    nnoremap <silent><buffer><expr> K
        \ defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> N
        \ defx#do_action('new_file')
    nnoremap <silent><buffer><expr> M
        \ defx#do_action('new_multiple_files')
    nnoremap <silent><buffer><expr> d
        \ defx#do_action('remove')
    nnoremap <silent><buffer><expr> r
        \ defx#do_action('rename')
    nnoremap <silent><buffer><expr> !
        \ defx#do_action('execute_command')
    nnoremap <silent><buffer><expr> yy
        \ defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> .
        \ defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> h
        \ defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> cd
        \ defx#do_action('cd', getcwd())
    nnoremap <silent><buffer><expr> q
        \ defx#do_action('quit')
    nnoremap <silent><buffer><expr> <Space>
        \ defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> *
        \ defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> j
        \ line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> k
        \ line('.') == 1 ? 'G' : 'k'
    nnoremap <silent><buffer><expr> <C-r>
        \ defx#do_action('redraw')
    nnoremap <silent><buffer><expr> <C-g>
        \ defx#do_action('print')
    nnoremap <silent><buffer><expr> v
        \ defx#do_action('multi', [['drop', 'vsplit'], 'quit'])
    nnoremap <silent><buffer><expr> f
        \ defx#do_action('search', expand('%:p:h'))
endfunction
```

---

### Reference

- https://github.com/Shougo/defx.nvim
- https://github.com/kristijanhusak/defx-git
- https://github.com/kristijanhusak/defx-icons
- [Golang 開發環境 - 使用 neovim | no code no pain](https://amikai.github.io/2020/09/03/go_neovim_env/)
- [Defx: file explorer plugin for Neovim | eed3si9n](https://eed3si9n.com/defx)


[defx]: https://github.com/Shougo/defx.nvim
[git]: https://github.com/kristijanhusak/defx-git
[icons]: https://github.com/kristijanhusak/defx-icons
