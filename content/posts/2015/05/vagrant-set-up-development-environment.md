---
title: '用 Vagrant 建立開發環境'
date: 2015-05-30T16:14:00+08:00
tags: [virtualbox, vagrant, nginx, docker, ubuntu]
---

身為一個程式設計師，一定會做一件事，就是建立開發環境，而建立開發環境卻是很煩人的過程。
之前為了解決這個問題，自己動手記錄了開發環境會使用的工具跟服務，寫了一個很簡單的 shell script。

現在虛擬機當道~使用上有很多的方便，在看到 base on 虛擬機的工具出現，也是時候試一試了。

## 什麼是 Vagrant

Vagrant 是流浪漢…
Vagrant 是一個工具，幫助你設定 虛擬機；剛開始是針對 Virtrual Box，現在就不只了。

## 安裝 Vagrant

在 ubuntu 上安裝的方法：

```sh
$ sudo apt-get install vagrant
```

## 用 Vagrant 建立虛擬機

首先增加一個 ubuntu 14.04 LTS 的 Box (打包好的 guest os)

```sh
$ vagrant box add ubuntu/trusty64
```

box 會從 https://atlas.hashicorp.com/boxes/search 抓下來，可以輸入以下指令查看你已經抓好的 boxes

```sh
$ vagrant box list
```

使用 Vagrant 會建立一些設定檔，所以我們需要先建一個資料夾，讓設定檔放在裡面

```sh
$ mkdir vagrant_develop
$ cd vagrant_develop/
```

產生一台虛擬機

```sh
$ vagrant init ubuntu/trusty64
A `Vagrantfile` has been placed in this directory. You are now
ready to `vagrant up` your first virtual environment! Please read
the comments in the Vagrantfile as well as documentation on
`vagrantup.com` for more information on using Vagrant.
```

虛擬機產生之後，會出現一個 `Vagrantfile` 在資料夾內

啟動她！
```sh
$ vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Importing base box 'ubuntu/trusty64'...
==> default: Matching MAC address for NAT networking...
==> default: Checking if box 'ubuntu/trusty64' is up to date...
==> default: Setting the name of the VM: vagrant_develop_default_1433005676358_75321
==> default: Clearing any previously set forwarded ports...
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
==> default: Forwarding ports...
    default: 22 => 2222 (adapter 1)
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
    default: SSH address: 127.0.0.1:2222
    default: SSH username: vagrant
    default: SSH auth method: private key
    default: Warning: Connection timeout. Retrying...
    default: Warning: Remote connection disconnect. Retrying...
    default:
    default: Vagrant insecure key detected. Vagrant will automatically replace
    default: this with a newly generated keypair for better security.
    default:
    default: Inserting generated public key within guest...
    default: Removing insecure key from the guest if its present...
    default: Key inserted! Disconnecting and reconnecting using new SSH key...
==> default: Machine booted and ready!
==> default: Checking for guest additions in VM...
==> default: Mounting shared folders...
    default: /vagrant => /home/nyo/vagrant_develop
```

啟動的過程中 Vagrant 做了不少事：
- port forwarding,
- deploy ssh public key,
- mount shared folders...


虛擬機啟動之後，怎麼使用呢? ssh 連進去就可以開始用了
```
$ vagrant ssh
```

測試結束，想要關掉虛擬機的話，請輸入：
```
$ vagrant halt
```

又或是虛擬機用不到要刪掉了，你可以輸入：
```
$ vagrant destroy
```

Vagrant 會幫你把虛擬機刪掉

## 用 Vagrant 建立 nginx 環境

建立一支 bootstrap.sh 的檔案，將安裝 nginx 的指令放入檔案中
```bash
#!/usr/bin/env bash

apt-get update
apt-get -y install nginx
```

在 Vagrantfile 增加設定，
加入 bootstrap.sh 腳本跟一行 port forwarding 的設定，讓 host os 可以連到 guest os
```ruby
Vagrant.configure("2") do |config|
  config.vm.provision :shell, path: "bootstrap.sh"
  config.vm.network "forwarded_port", guest: 80, host: 8080
end
```

設定完成後，執行 `$ vagrant reload --provision` 或是 `$ vagrant provision`，重新配置虛擬機，載入新的 Vagrantfile

現在你可以 curl 連到剛剛裝好的 nginx 服務了
```
$ curl localhost:8080
```

## Summary

明明我的開發環境需要的服務一堆，但以上範例只偷懶裝了 nginx...
不過這還好，可以依此類推；之後有玩出不一樣的東西再寫一篇新的筆記了。

有了 Vagrant 的第一個好處大概是我可以從「一直安裝環境」變成「一直 vagrant init」吧XD

再另外附帶一提，之後打算加上 Docker 來試試。

---

### Reference
https://docs.vagrantup.com/v2/
http://gogojimmy.net/2013/05/26/vagrant-tutorial/
http://www.codedata.com.tw/social-coding/vagrant-tutorial-1-developer-and-vm/
