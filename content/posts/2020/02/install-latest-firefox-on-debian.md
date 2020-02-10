---
title: "Install Lastest Firefox on Debian"
date: 2020-02-10T23:06:49+08:00
tags: [firefox, debian]
---

Debian 的套件庫中只有 Firefox-ESR，跟 Firefox 官網的版本有點差距

想要使用最新的 Firefox  就是，直接從官網下載安裝！！！

## 下載

```
$ tar xvf firefox-72.0.2.tar.bz2
$ sudo mv firefox /opt
```

## 建立 firefox.desktop

```
$ sudo vi /usr/share/applications/firefox-stable.desktop
```

```
[Desktop Entry]
Name=Firefox Stable
Comment=Web Browser
Exec=/opt/firefox/firefox %u
Terminal=false
Type=Application
Icon=/opt/firefox/browser/chrome/icons/default/default128.png
Categories=Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/vnd.mozilla.xul+xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true
```

然後享用 Firefox

---

### Reference
- https://wiki.debian.org/Firefox

