---
title: "優雅的關機 (Graceful Shutdown) Goroutine"
date: 2021-07-06T23:24:06+08:00
tags: [golang, goroutine]
---

`Graceful shutdown` 直接翻譯是 **「優雅的關機」**

這種做法是在收到程式`終止`的指令時，先處理好執行中的動作才結束程式。

使用這個機制可以正確的關閉連線，完成處理到一半的任務。能夠保障工作跟資料的完整性，避免突然的中止程式造成一些奇怪的問題。

實作方法有很多種，這次要試試看使用 `select + channel` 來達到 `graceful shutdown` 自己寫的 goroutine。

## 實作

### struct

在 `struct` 宣告一個 `stopChan` 用來傳送中止訊息

```go
type grace struct {
	stopChan chan struct{}
}
```

用 `select` 語法，一個 `case` 定時執行任務，一個 `case` 等待 `stopChan` 傳值

接到 `stopChan` 傳來資料後，就會離開 for loop，結束這個 function

```go
func (g *grace) Run() {
	for {
		select {
		case <-time.After(time.Second):
			fmt.Println(">", time.Now())
		case <-g.stopChan:
			fmt.Println("stop run method")
			return
		}
	}
}
```


再加上一個 Stop method 發送資料到 `stopChan`
```go
func (g *grace) Stop() {
	g.stopChan <- struct{}{}
}
```

### main function

使用 `go g.Run()` 建立一個 goroutine 在背景運行

`termChan` 等待 interrupt 訊號，收到訊號後執行 `Stop()` 停止 goroutine 才結束程式

```go
func main() {
	fmt.Println("start...")

	termChan := make(chan os.Signal)
	signal.Notify(termChan, syscall.SIGTERM, syscall.SIGINT)

	g := NewGrace()
	go g.Run()

	// stop goroutine when catch interrupt signal
	<-termChan
	log.Print("SIGTERM received. close goroutine\n")
	g.Stop()

	fmt.Println("end...")
}
```

## 完整程式碼

```go
package main

import (
	"fmt"
	"log"
	"os"
	"os/signal"
	"syscall"
	"time"
)

func main() {
	fmt.Println("start...")

	termChan := make(chan os.Signal)
	signal.Notify(termChan, syscall.SIGTERM, syscall.SIGINT)

	g := NewGrace()
	go g.Run()

	// stop goroutine when catch interrupt signal
	<-termChan
	log.Print("SIGTERM received. close goroutine\n")
	g.Stop()

	fmt.Println("end...")
}

type grace struct {
	stopChan chan struct{}
}

func NewGrace() *grace {
	return &grace{
		stopChan: make(chan struct{}),
	}
}

// Run service with timer
func (g *grace) Run() {
	for {
		select {
		case <-time.After(time.Second):
			fmt.Println(">", time.Now())
		case <-g.stopChan:
			fmt.Println("stop run method")
			return
		}
	}
}

// Stop running service
func (g *grace) Stop() {
	g.stopChan <- struct{}{}
}
```

---

## Reference

- [\[Go 教學\] 什麼是 graceful shutdown? - 小惡魔 - AppleBOY](https://blog.wu-boy.com/2020/02/what-is-graceful-shutdown-in-golang/)
