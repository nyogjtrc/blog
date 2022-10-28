---
title: "Gitlab CI 推送 docker image 到 ECR 私有儲存庫"
date: 2022-10-29T01:11:06+08:00
tags: [gitlab-ci, aws]
---

最近在尋找適合放 docker image 的私有 registry，因為平常有在用 AWS，所以就來試一下 AWS 的 registry 服務 ECR

gitlab 版本: gitlab 15.3
gitlab runner 運作模式: Docker

## 準備動作

先確定 aws 帳號有 ECR 的使用權限，如果有需要微調權限設定可以參考官方文件: [Pushing an image - Amazon ECR](https://docs.aws.amazon.com/AmazonECR/latest/userguide/image-push.html)

在 ECR 建立 private repository，會拿到 repository 的 uri。我建立了一個 `hello-ci` 的 repostiroy uri 長得像這樣 `000000000000.dkr.ecr.ap-northeast-1.amazonaws.com/hello-ci`

gitlab runner 要有使用 ECR 的權限，有兩種方法可以做到
- runner 的 ec2 掛上有 ECR 權限的 IAM 角色
- 將有 ECR 權限的 access key 設定在 CI 內

## Gitlab runner

因為我們 runner 是使用 Docker 運作模式，這次測試我使用 Use Docker socket binding 的方式。

要掛載 `/var/run/docker.sock` 給 runner 使用

設定 runner 的 config，在 `[runners.docker]` 的 volumes 增加掛載設定

```toml
[[runners]]
  ...
  [runners.docker]
    tls_verify = false
    image = "alpine:latest"
    privileged = false
    disable_entrypoint_overwrite = false
    oom_kill_disable = false
    disable_cache = false
    volumes = ["/var/run/docker.sock:/var/run/docker.sock", "/cache"]
```

## Gitlab CI

ci job 的 image 要使用 dind 的 docker image，還需要安裝 aws cli 以便登入 ECR。

編輯 `.gitlab-ci.yml`，加入 build docker image 的 stage。
```yaml
variables:
  DOCKER_REGISTRY: 000000000000.dkr.ecr.ap-northeast-1.amazonaws.com
  AWS_DEFAULT_REGION: ap-northeast-1

stages:
  - release

upload-docker-image:
  stage: release
  image:
    name: docker:20.10.21-dind
  before_script:
    - docker info
    - apk add --no-cache python3 py3-pip
    - pip3 install --no-cache-dir awscli
  script:
    - docker build -t hello-ci .
    - docker tag hello-ci:latest $DOCKER_REGISTRY/hello-ci:latest
    - aws ecr get-login-password | docker login --username AWS --password-stdin $DOCKER_REGISTRY
    - docker push $DOCKER_REGISTRY/hello-ci:latest
```

最後就是 push commit 到 gitlab 觸發 CI 便大功告成了。

## Reference
- [Pushing an image - Amazon ECR](https://docs.aws.amazon.com/AmazonECR/latest/userguide/image-push.html)
- [Use Docker to build Docker images | GitLab](https://docs.gitlab.com/ee/ci/docker/using_docker_build.html)
