---
title: "Install Virtualbox 5.2 On Debian Testing"
date: 2018-12-30T15:01:29+08:00
tags: [Virtualbox, Debian]
---

## 增加 source list

debian testing (buster, 10) 要選擇 bionic 版本, 避免套件相依問題

```
echo "deb https://download.virtualbox.org/virtualbox/debian bionic contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
```

## 增加 apt key

```
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
```

## 安裝 Virtualbox

```
sudo apt update
sudo apt install virtualbox-5.2
```

ps. Virtualbox 6.0 在 2018/12/18 發佈了

### Reference

- https://www.virtualbox.org/wiki/Linux_Downloads

