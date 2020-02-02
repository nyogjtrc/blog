---
title: "比較 Git Workflows"
date: 2020-02-02T12:37:15+08:00
tags: [git, github, gitlab]
---

團隊在合作開發程式時，一定少不了 git 這個重要的工具，怎麼有效的使用 git 常常是一大課題。

這邊整理一下目前常見的幾種 git 分支管理策略。

## Git flow

![](/posts/2020/02/git-flow.png)

出處: https://nvie.com/posts/a-successful-git-branching-model/

分支策略:

- 分成主要分支跟支援分支，依照你當下的情況來決定要使用哪種分支
- 主要分支
	- master: 穩定的隨時可以釋出到正式環境的版本
	- develop: 開發的基礎分支
- 支援分支
	- feature: 增加新的功能時使用的分支，從 develop 分支出來，合併到 develop 分支
	- release: 當要對開發完成的功能做最終調整準備合併到 master 時使用的分支，從 develop 分支出來，合併到 develop 跟 master 分支
	- hotfix: 當 master 有需要馬上排除的狀況時使用的分支，從 master 分支出來，合併到 master 跟 develop 分支

特色:

- 分支的使用情境分類清楚
- 相對複雜，沒那麼適合 CI/CD
- 維護兩個主要分支的成本較高
- 如果是小型簡單的專案，master 跟 develop 分支的差別就很小，不太需要維持兩個分支

## Github flow

![](/posts/2020/02/github-flow.png)

出處: https://guides.github.com/introduction/flow/

分支策略:

- 主要分支只有 master
- 流程
	- 建立一個分支
	- 新增提交
	- 建立 pull request
	- 討論與檢視程式碼
	- 部署
	- 合併

特色:

- 簡單
- 適合 CI/CD
- master 保持在隨時可以部署的狀態
- 遇到有多個環境或是多個版本時，github flow 就無法支援了

## Gitlab flow

![](/posts/2020/02/gitlab-flow.png)

出處:

- https://about.gitlab.com/blog/2014/09/29/gitlab-flow/
- https://docs.gitlab.com/ee/topics/gitlab_flow.html
- https://about.gitlab.com/blog/2016/07/27/the-11-rules-of-gitlab-flow/

分支策略:

- 主要分支: master
- 當有持續更新的系統時，運用分支來部署版本到對應的環境
- 當有定期釋出版本的軟體時，運用分支來釋出對應的版本

特色:

- github flow 進階版
- 適合 CI/CD
- 多種的部署策略
	- Environment branches, Release branches, tag
- 比 github flow 複雜，當你有多個部署環境時，會變的更加復雜

## 總結

團隊選擇自己的 git workflow 時:

- 盡可能的簡單
- 能夠適應 CI/CD
- 唯一主要分支 master
- 配合部署策略

以上結論，是近期覺得比較合適的重點

---

## Reference

- https://medium.com/@patrickporto/4-branching-workflows-for-git-30d0aaee7bf
- https://blog.wu-boy.com/2017/12/github-flow-vs-git-flow/comment-page-1/
