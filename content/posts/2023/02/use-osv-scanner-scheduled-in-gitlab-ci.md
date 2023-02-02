---
title: "在 Gitlab CI 排程執行 OSV-Scanner"
date: 2023-02-02T23:31:09+08:00
tags: [gitlab-ci, ci]
---
[Google Online Security Blog: Announcing OSV-Scanner: Vulnerability Scanner for Open Source](https://security.googleblog.com/2022/12/announcing-osv-scanner-vulnerability.html)

Google 在 2022 年 12 月發佈 [OSV-Scanner](https://github.com/google/osv-scanner) 這個漏洞掃描工具，可以檢查你的專案所使用的依賴開源套件是否有漏洞。支援 npm, go mod, composer, yarn 等相當多的套件管理工具。

## OSV-Scanner 使用方式

OSV-Scanner 可以直接安裝執行檔
```bash
go install github.com/google/osv-scanner/cmd/osv-scanner@v1
```

也有提供 docker image
```bash
docker pull ghcr.io/google/osv-scanner:latest
```

## 在 Gitlab CI 排程執行 OSV-Scanner

漏洞掃描工具不需要很頻繁的使用，只要有定期的檢查過就可以了。這樣的情境就很適合放到 CI 裡，設定成排程每天或是每週檢查一次。

所以馬上拿我自己用 golang 開發的工具 https://gitlab.com/laisiacode/gitlab-voice 來試試

## 設定 Gitlab CI

`.gitlab-ci.yml` 加入以下 job
```yml
osv-scan:
  image:
    name: ghcr.io/google/osv-scanner:latest
    entrypoint: [""]
  rules:
    - if: $CI_PIPELINE_SOURCE == "schedule"
  script:
    - /osv-scanner --lockfile=go.mod
```

job 設定細節如下:
- 直接使用官方打包好的 image
- 要讓 gitlab runner 可以正常使用 osv-scanner image 要更改 entrypoint
- rules 設定本 job 會由 schedule 觸發

增加 gitlab ci schedule:
- 到 gitlab 的 sidebar 選 **CI/CD** > **Schedules**	
- 點選 **New Schedule**，開始設定說明時間頻率等資料
- 設定完畢點選 **Save pipeline schedule**

## 實測

要測試 CI 是否可以正確執行，我們可以到 Scheudles 頁面點選 **Play**

CI 結果:

![](/posts/2023/02/osv-scanner-gitlab-ci.png)

OSV-Scanner 幫我找到有漏洞的套件了！馬上去更新套件！

## Reference
- [Google Online Security Blog: Announcing OSV-Scanner: Vulnerability Scanner for Open Source](https://security.googleblog.com/2022/12/announcing-osv-scanner-vulnerability.html)
- [Google 釋出 漏洞掃描工具：OSV-Scanner – Tsung's Blog](https://blog.longwin.com.tw/2023/01/google-release-vulnerability-code-scan-osv-scanner-2023/)
- https://github.com/google/osv-scanner
- [Scheduled pipelines | GitLab](https://docs.gitlab.com/ee/ci/pipelines/schedules.html)
