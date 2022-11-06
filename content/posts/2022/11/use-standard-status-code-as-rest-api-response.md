---
title: "使用標準的 HTTP 狀態碼(status code)做為 REST API 回應結果"
date: 2022-11-06T21:11:34+08:00
tags: [rest api, http]
---

## REST API 回應結果設計

設計 REST API 時，要好好的處理錯誤狀況並回應清楚的結果可以是一門很深的學問。
基於 HTTP 設計的 REST API，想要 API 使用者掌握狀況，那正確的使用 HTTP 狀態碼做回應就是最正確的辦法。

HTTP 本身就已經定義了一系列的回應狀態碼(response status codes):
- 1xx: 參考資訊 (Informational)
- 2xx: 成功 (OK)
- 3xx: 重新導向 (Redirection)
- 4xx: 用戶端錯誤 (Client Error)
- 5xx: 伺服器錯誤 (Server Error)

### 程式決定狀態碼的基礎流程

在開發 REST API 最常用的 HTTP 狀態碼會有以下三類:
- 2xx: 成功 (OK)
- 4xx: 用戶端錯誤 (Client Error)
- 5xx: 伺服器錯誤 (Server Error)

決定狀態碼的流程圖:

![](/posts/2022/11/http-status-code-decision-flow.png)

程式的基礎判斷流程很單純:
- 當異常狀況是因為「用戶端」請求內容有問題時，回應狀態碼就會從 4xx 中選擇。
- 當異常狀況是為「伺服器」的程式處理問題，則是從 5xx 選出狀態碼回應。
- 程式順利完成的話，就從 2xx 選適合的狀態碼回應，完成這次請求。

確定狀態碼之後，如果是成功時，我們可能需要將資料放入回應內容(response body)。如果是錯誤的情況下，則是可以將錯誤的詳細狀況放在回應內容(response body)，讓用戶端更加清楚發生了什麼事。

以下提供三個範例:

成功建立資料
```
201 Created
{"id":100}
```

無效的請求參數
```
400 Bad Request
{"status":"invalid argument"}
```

使用者不存在
```
404 Not Found
{"status":"user not found"}
```


## 狀態碼跟回應內容分離的 API 設計

平常跟不同的團隊或是公司在對接 API 時，會遇到一種完全不一樣的 REST API 設計。這種設計是不使用 HTTP 狀態碼回應錯誤情況，反而在 response 設計另外一套 error code 來告知 client 發生了什麼錯誤。

這樣的設計概念是將 HTTP 狀態碼跟回應內容分開看待，HTTP狀態碼代表 web 伺服器處理結果，回應內容代表業務程式碼處理的結果。

200 OK 是業務邏輯程式碼執行完畢，想要知道「業務邏輯」的結果，還要進一步的看過回應內容才能得知最終結果。

以下提供三個範例:

成功建立資料
```
200 OK
{"status":"ok","id":100}
```

無效的請求參數
```
200 OK
{"status":"error","message":"invalid argument"}
```

使用者不存在
```
200 OK
{"status":"error","message":"user not found"}
```

### 200 OK 加上 error 的訊息，到底是成功還是錯誤?

這樣的設計我們可以發現一個明顯的矛盾之處，就是你一定會遇到「200 OK 加上 error 的訊息」，而這樣的回應結果讓人困惑。

從用戶端開發者的角度來看，要因應兩套回應格式，需要「客製化」設計兩階段的判斷邏輯。這樣的「客製化」會讓程式會變複雜。

## 兩種設計的分析比較

使用 HTTP 狀態碼的設計:
- 設計簡單，依照HTTP 狀態碼的定義即可，較符合 Kiss(Keep it simple and stupid) 原則
- 用戶端處理邏輯簡單，只要跟著 HTTP 狀態碼的定義就可以知道發生什麼事。
- 伺服器端開發跟維護容易，只要找出錯誤情境所適合的狀態碼即可。

狀態碼跟回應內容分離的設計:
- 設計複雜除了 HTTP 狀態碼的定義，還要設計一套業務邏輯的狀態。
- 增加用戶端使用上的複雜度，需要經過「客製化」的兩階段狀態判斷，才可以知道發生什麼事。
- 伺服器端開發複雜，需要自己設計一套錯誤代碼，並且要持續的維護它。
- 會產生矛盾的結果

如果我們希望我們所設計的 API 系統給人感覺是完善的一套系統，而非破碎的組裝系統。那麼「使用 HTTP 狀態碼設計 API 回應」是最佳選擇。特別是從 Client 的角度來看，就只知道是 API，看不到 API 後的任何架構細節。

如果想要開發以及維運上更加輕鬆，相信簡單的設計是最佳選擇。

## Reference
- [Best practices for REST API design - Stack Overflow Blog](https://stackoverflow.blog/2020/03/02/best-practices-for-rest-api-design/)
- [Web API design best practices - Azure Architecture Center | Microsoft Learn](https://learn.microsoft.com/en-us/azure/architecture/best-practices/api-design)
- [HTTP 狀態碼 - HTTP | MDN](https://developer.mozilla.org/zh-TW/docs/Web/HTTP/Status)
- [Returning http 200 OK with error within response body - Stack Overflow](https://stackoverflow.com/questions/27921537/returning-http-200-ok-with-error-within-response-body)
- [server - Should I use HTTP status codes to describe application level events - Software Engineering Stack Exchange](https://softwareengineering.stackexchange.com/questions/305250/should-i-use-http-status-codes-to-describe-application-level-events)
