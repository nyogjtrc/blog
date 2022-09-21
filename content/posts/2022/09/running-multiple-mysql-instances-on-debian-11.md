---
title: "在 Debian 11 上執行多個 MySQL 實例"
date: 2022-09-22T00:15:28+08:00
tags: [MySQL, debian]
---

測試環境:
- 使用 vagrant 開 vm 來測試
- vagrant box debian/bullseye64

## 安裝 MySQL

### 更新 APT
這個版本的 apt 沒有 MySQL server，所以我們要先更新 apt 套件庫。下載 mysql 官方提供的 `mysql-apt-config` 來安裝即可。

```
$ wget https://repo.mysql.com//mysql-apt-config_0.8.23-1_all.deb
$ sudo apt update
$ sudo apt install gnupg
$ sudo dpkg -i mysql-apt-config_0.8.23-1_all.deb
```

安裝時會跳出一個 MySQL 的配置畫面，預設是 `mysql-8.0`，我們直接使用預設即可，按 `Tab` 選 `OK`，再按下 `Enter`。

### 安裝 MySQL

更新 apt 後，就有 `mysql-server` 可以安裝了

```
$ sudo apt update
$ sudo apt install mysql-server
```

安裝時會跳出幾個畫面請你做一些設定
- 輪入 root 密碼
- 再次輪入 root 密碼
- 選擇 authentication plugin: 我們就選官方建議的 `Use Strong Password Encryption`

到此就安裝完成，安裝程式也會自動啟動 mysql server。我們可以使用 `systemd` 的指令檢查服務的狀態

```
$ systemctl status mysql
● mysql.service - MySQL Community Server
     Loaded: loaded (/lib/systemd/system/mysql.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2022-09-20 16:38:52 UTC; 1min 48s ago
       Docs: man:mysqld(8)
             http://dev.mysql.com/doc/refman/en/using-systemd.html
    Process: 12822 ExecStartPre=/usr/share/mysql-8.0/mysql-systemd-start pre (code=exited, status=0/SUCCESS)
   Main PID: 12857 (mysqld)
     Status: "Server is operational"
      Tasks: 38 (limit: 527)
     Memory: 373.2M
        CPU: 1.447s
     CGroup: /system.slice/mysql.service
             └─12857 /usr/sbin/mysqld
```

可以看到服務是正常運作的狀態 `active (running)`


## 執行多個 MySQL

再來我們要開始調整設定在 Debian 上執行多個 MySQL instances。官方的教學很清楚，一步步跟著做就好了。

這次的測試，我們要啟動兩個 instances 名稱分別是 `replica01` 跟 `replica02`

### 編輯 MySQL Config
```
$ sudo vi /etc/mysql/mysql.conf.d/mysqld.cnf
```

追加以下的配置:
```
[mysqld@replica01]
datadir=/var/lib/mysql-replica01
socket=/var/lib/mysql-replica01/mysql.sock
port=3307
log-error=/var/log/mysql/replica01-error.log

[mysqld@replica02]
datadir=/var/lib/mysql-replica02
socket=/var/lib/mysql-replica02/mysql.sock
port=3308
log-error=/var/log/mysql/replica02-error.log
```

### 用 systemd 指令啟動 MySQL 服務

執行以下 systemd 指令，啟動我們設定好的 `replica01` 跟 `replica02`
```
$ sudo systemctl start mysql@replica01
$ sudo systemctl start mysql@replica02
```

成功後，可以用以下 systemd 指令查看狀態

```
$ sudo systemctl status 'mysql@replica*'
```

ps. 一個 MySQL instance 需要至少約 400MB 的記憶體，請確認你的 vm 有足夠的記憶體開多個 instances

### 登入

我們新啟動的 `replica01` 跟 `replica02` 兩個 MySQL 服務並沒有設定 root 密碼，如果想用 `mysql -u root -p` 登入是沒辦法成功的。

因此，我們選擇另外一個 localhost 可以使用的登入方式，就是使用 `socket`

```
$ sudo mysql --socket=/var/lib/mysql-replica01/mysql.sock -u root
...
mysql>
```

成功登入了，現在你可以開始使用 MySQL 了

## 是怎麼運作的?

可以啟動多個服務的 MySQL 是使用 `/lib/systemd/system/mysql@.service` 這個 service 設定，這是一開始安裝好就有的。

我們打開檔案，跟原本的 `mysql.service` 比較一下
```
$ less /lib/systemd/system/mysql@.service

ExecStart=/usr/sbin/mysqld --defaults-group-suffix=@%I
```
可以發現 `ExecStart` 的指令不太一樣，多使用了 `--defaults-group-suffix` 的參數，後面還有一個 `%I` 的變數。

這樣設定可以使得 systemd 指令中的 serivce name @ 符號後的字串會帶到 %I


## AppArmor

在目前 Debian 的環境上沒有寫入 `/var/lib/mysql-replica01` 失敗的情況，不過前一陣子在 Ubuntu 上測試有遇到。

如果有寫入權限不足的情況，記得修改 `/etc/apparmor.d/usr.sbin.mysqld`，確保有權限寫入 `datadir`。

## Reference
- [MySQL :: MySQL 8.0 Reference Manual :: 2.5.9 Managing MySQL Server with systemd](https://dev.mysql.com/doc/refman/8.0/en/using-systemd.html)
