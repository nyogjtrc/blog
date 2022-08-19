---
title: "如何在 github 建立 ansible role"
date: 2022-08-20T01:22:18+08:00
tags: [ansible]
---

## 什麼是 ansible role

ansible 的 role 讓我們可以封裝許多的 task 跟 handlers 等等 playbook 的工作。

## 怎麼開始寫 role

這次我們來寫一個 hello world

ansible 有提供 `ansible-galaxy` 的指令，用來管理 role。可以使用這個指令來產生 role 的基本資料夾跟檔案。

```
$ ansible-galaxy init ansible-hello
- Role ansible-hello was created successfully
```

用 `tree` 看一下有什麼檔案
```
$ tree -a
.
├── .travis.yml
├── README.md
├── defaults
│   └── main.yml
├── files
├── handlers
│   └── main.yml
├── meta
│   └── main.yml
├── tasks
│   └── main.yml
├── templates
├── tests
│   ├── inventory
│   └── test.yml
└── vars
    └── main.yml

8 directories, 9 files
```
ansible 執行時，預設會尋找 `main.yml` 檔案，所以內容都要放在裡面，role 才能夠正確的被使用

我們在以下需要使用到的檔案放入 yml 設定，其他用不到的檔案就可以先刪除了。

`tasks/main.yml`: 存放 task
```yml
---
- name: Print 'hello world'
  debug:
    msg: "hello {{ who }}"
```

`defaults/main.yml`: 存放變數預設值
```yml
---
who: world
```

`meta/main.yml`: 這份 role 的基本資訊、依賴 role 等資訊
```yml
galaxy_info:
  author: nyogjtrc
  description: this is a practice for writing ansible role

  license: MIT

  min_ansible_version: 2.1
```

以上檔案都寫好之後，就可以 commit 並 push 到 github 上了。

## 安裝 role

我們可以使用 `ansible-galaxy install git+網址` 來安裝我們寫好的 role
```sh
$ ansible-galaxy install git+https://github.com/nyogjtrc/ansible-hello
Starting galaxy role install process
- extracting ansible-hello to /Users/nyo/.ansible/roles/ansible-hello
- ansible-hello was installed successfully
```

ps. 如果沒有 `meta/main.yml` 就無法用 `ansible-galaxy install` 安裝
```sh
$ ansible-galaxy install git+https://github.com/nyogjtrc/ansible-hello
Starting galaxy role install process
[WARNING]: - ansible-hello was NOT installed successfully: this role does not appear to have a meta/main.yml file.
```

## 使用 role

我寫一個簡單的 `playbook.yml` 來測試裝好的 `role` 是否可以使用
```yml
---
- hosts: localhost
  roles:
    - { role: ansible-hello, who: water }
```

執行 playbook
```sh
$ ansible-playbook playbook.yml
PLAY [localhost] ******************************************

TASK [Gathering Facts] ******************************************
ok: [localhost]

TASK [ansible-hello : Print 'hello world'] ******************************************
ok: [localhost] => {
    "msg": "hello water"
}
```

寫在 `ansible-hello` 裡的 task 成功的被執行，變數 `who` 也成功被替換成 `water` 了

## Reference

- [Roles — Ansible Documentation](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html)
