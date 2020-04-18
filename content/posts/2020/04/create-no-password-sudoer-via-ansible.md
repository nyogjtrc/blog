---
title: "用 Ansible 建立一個不需要密碼的 sudoer"
date: 2020-04-18T23:14:28+08:00
tags: [ansible, sudo]
---

## 把 user 設定成 sudoer 的方式

#### 直接修改 /etc/sudoers
最暴力的作法，不小心打錯字就 game over

#### 透過 visudo 指令去修改
visudo 會幫忙檢查有沒有打錯字

#### 增加檔案到 /etc/sudoers.d/ 裡面
不會改動 `/etc/sudoers`

## 使用 ansible 的選擇
使用 ansible 來增加 sudo 權限時，我們只要在 `/etc/sudoers.d/` 裡面增加有設定 sudoer 的檔案就好

不會動到預設的檔案，單一檔案也比較容易管控

#### playbook rookie.yml

```yaml
---
- name: Create new user with sudo privilege
  hosts: all
  become: yes
  tasks:
    - name: Create new user
      user:
        name: rookie
        shell: /bin/bash
    - name: Set authorized key taken from file
      authorized_key:
        user: rookie
        state: present
        key: "{{ lookup('file', '~/.ssh/id_rsa.pub') }}"
    - name: Add user rookie to sudo
      lineinfile:
        path: /etc/sudoers.d/rookie
        line: 'rookie ALL=(ALL) NOPASSWD: ALL'
        state: present
        mode: 0440
        create: yes
        validate: 'visudo -cf %s'
```

執行

```shell
$ ansible-playbook -i host rookie.yml
```
