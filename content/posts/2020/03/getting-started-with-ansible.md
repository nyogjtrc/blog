---
title: "Ansible 新手上路"
date: 2020-03-29T17:58:46+08:00
tags: [ansible]
---

## 介紹

- 命名由來：小說 Ender's Game (安德的遊戲 or 戰爭遊戲)
- 官網上的 slogan `Automation for everyone`
- 一個自動化工具，幫你完成組態管理、程式部署等工作
- 實現 Infrastructure as code (IaC)
- 其他類似的工具: Puppet, SaltStack, Chef, Terraform

優點:
- 只要有 ssh 跟 python 就可以運作
- 以 Yaml 格式編寫
- 被管理的 server 不需要另外安裝 agent

## 系統需求

**控制端**
- Python 2 (version 2.7) or Python 3 (versions 3.5 and higher)

**被管理端**
- SSH
- Python 2 (version 2.6 or later) or Python 3 (version 3.5 or later)

## 安裝

先安裝 python 的套件管理工具 pip 或 pip3，再用 pip 安裝 ansible

```sh
$ pip3 install ansible
```

## 設定

建立一個資料夾來放 ansible 需要的檔案

```sh
$ mkdir hello-ansible; cd hello-ansible;
```

用 vagrant 開一個測試機

```sh
$ vagrant init ubuntu/trusty64
$ vagrant up
```

設定組態檔 `ansible.cfg`，直接指定資料夾中的 hosts 為主要的主機清單

```cfg
[defaults]
inventory = hosts
```

設定 inventory 主機清單 `hosts`，variables 配合 vagrant 的預設值

```yaml
all:
  hosts:
    server-01:
      ansible_ssh_host: 127.0.0.1
  vars:
    ansible_user: vagrant
    ansible_ssh_port: 2222
    ansible_ssh_private_key_file: .vagrant/machines/default/virtualbox/private_key
    ansible_ssh_extra_args: "-o StrictHostKeyChecking=no"
```

## 測試

ping 主機

```sh
$ ansible all -m ping
server-01 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
```

對所有的主機下指令

```sh
$ ansible all -m command -a 'echo Hello World.'
server-01 | CHANGED | rc=0 >>
Hello World.
```

## Playbook

Playbook 的翻譯是「劇本」，就如同字面上的意思，把你想要命令主機做的事情一件一件到 Playbook 中，讓 ansible 幫你一一的完成這些工作。

建立 `ping.yml` 鍵入你要處理的工作

```yaml
---
- hosts: "{{ variable_host | default('all') }}"
  tasks:
    - name: Ping server
      ping:
      register: result
    - name: Print result
      debug:
        msg: "{{ result }}"
    - name: Show uptime
      command: uptime
      register: uptime
    - name: Print uptime
      debug:
        msg: "{{ uptime.stdout }}"

# vim: set filetype=yaml.ansible:
```

下指令 `ansible-playbook ping.yml` 就能看到執行結果

```sh
$ ansible-playbook ping.yml

PLAY [all] *********************************************************************

TASK [Ping server] *************************************************************
ok: [server-01]

TASK [Print result] ************************************************************
ok: [server-01] => {
    "msg": {
        "changed": false,
        "failed": false,
        "ping": "pong"
    }
}

TASK [Show uptime] *************************************************************
changed: [server-01]

TASK [Print uptime] ************************************************************
ok: [server-01] => {
    "msg": " 14:59:19 up  1:53,  1 user,  load average: 0.00, 0.01, 0.05"
}

PLAY RECAP *********************************************************************
server-01                  : ok=4    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

## 小結

一些寫 shell script 時要自己處理的事情，Ansible 或是一些 Module 都有了，不再需要重複造輪子

拿 playbook 跟 shell script 比較，一切都變得更加有結構性

剛開始使用時，其實也還不確定對工作效率的改善有多大的差距，就是一步一步的試下去


---

### Reference

- https://docs.ansible.com/ansible/latest/index.html
- https://blog.samchu.dev/2019/07/05/Ansible-install-and-introduction/
