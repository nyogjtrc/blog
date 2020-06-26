---
title: "Try gRPC, grpc-gateway With Go"
date: 2018-07-09T14:14:03+08:00
tags: [gRPC, go, RESTful]
---

## 什麼是 gRPC

- Google 推出的 RPC framework
- 採用 Google 制定的 protocol buffers 當作資料傳輸格式
- 有 `proto` 工具可以把你寫好的 proto file 直接生成程式碼
- 比 RESTful API 更快、更有效率
- 更多請參考官網: [grpc / grpc.io](https://grpc.io/)

## 安裝

開始寫 gRPC 服務之前，要先安裝一些 protocol buffer 的工具

### protocol buffer compiler

以下是快速安裝的腳本:

```
#!/bin/bash

VERSION="3.6.0"
PLATFORM="linux-x86_64"
FILENAME="protoc-$VERSION-$PLATFORM.zip"

curl -LO "https://github.com/google/protobuf/releases/download/v$VERSION/$FILENAME"
sudo unzip -u $FILENAME -d /usr/local bin/protoc include/*

rm $FILENAME
```

也可以直接去官網下載: https://github.com/google/protobuf/releases

測試一下沒有安裝成功

```bash
$ protoc --version
libprotoc 3.6.0
```

### plugin for genrate go code

```bash
$ go get -u github.com/golang/protobuf/protoc-gen-go
```

### gRPC package for go

```bash
$ go get -u google.golang.org/grpc
```

## 開始寫 gRPC 服務

要有一個完整的 gRPC 服務，首先要寫 proto file 定義好服務提供的方法跟傳輸的資料格式

再由工具產生 pb.go 程式碼，最後跟著 pb.go 實作 server 跟 client 程式了

### 1. 建立 proto 文件

這裡簡單寫一個 echo service

```bash
$ mkdir proto; vi proto/echo.proto
```

```proto
syntax = "proto3";

package proto;

message EchoMessage {
  string value = 1;
}

service EchoServer {
  rpc Echo (EchoMessage) returns (EchoMessage) {}
}
```

更多的語法請參考: [Language Guide (proto3)](https://developers.google.com/protocol-buffers/docs/proto3)

### 2. 產生 go 程式碼

借由 protoc 產生程式碼

```bash
$ protoc --go_out=plugins=grpc:. proto/*.proto
```

會產生 `echo.pb.go` 裡面包括 server 端的 interface 跟 client 端的 程式

### 3. 建立 server 程式

開始實作 EchoServer

import 剛剛產生的 echo.pb.go
```go
import (
	pb "github.com/nyogjtrc/grpc-example/proto"
)
```

實作 Server 跟 方法:
```go
type echoServer struct{}

// Echo
func (s *echoServer) Echo(ctx context.Context, in *pb.EchoMessage) (*pb.EchoMessage, error) {
	reply := new(pb.EchoMessage)
	reply.Value = "echo:" + in.Value
	return reply, nil
}
```

完整程式碼:

```go
package main

import (
	"context"
	"fmt"
	"log"
	"net"

	pb "github.com/nyogjtrc/grpc-example/proto"

	"google.golang.org/grpc"
)

type echoServer struct{}

// Echo
func (s *echoServer) Echo(ctx context.Context, in *pb.EchoMessage) (*pb.EchoMessage, error) {
	reply := new(pb.EchoMessage)
	reply.Value = "echo:" + in.Value
	return reply, nil
}

func main() {
	fmt.Println("grpc example echo server :8888")

	lis, err := net.Listen("tcp", ":8888")
	if err != nil {
		log.Fatalf("can not listen %v", err)
	}

	var opts []grpc.ServerOption
	s := grpc.NewServer(opts...)
	pb.RegisterEchoServiceServer(s, &echoServer{})
	s.Serve(lis)
}
```

### 4. 建立 client 程式

```go
package main

import (
	"bufio"
	"context"
	"fmt"
	"log"
	"os"

	pb "github.com/nyogjtrc/grpc-example/proto"
	"google.golang.org/grpc"
)

func main() {
	var opts []grpc.DialOption
	opts = append(opts, grpc.WithInsecure())
	conn, err := grpc.Dial(":8888", opts...)
	if err != nil {
		log.Fatalf("fail to dial: %v", err)
	}
	defer conn.Close()

	client := pb.NewEchoServiceClient(conn)

	for {
		reader := bufio.NewReader(os.Stdin)
		fmt.Print("Enter text: ")
		text, _ := reader.ReadString('\n')

		r, err := client.Echo(context.Background(), &pb.EchoMessage{Value: text})
		if err != nil {
			log.Fatalf("%v.Echo error: %v", client, err)
		}
		fmt.Println(r.Value)
	}
}
```

### 5. 實測 gRPC server, client

執行 server
```bash
$ go run server/main.go
grpc example echo server :8888
```

執行 client
```bash
$ go run client/main.go
Enter text: 123
echo:123

Enter text: hello
echo:hello
```

## 增加 gRPC gateway

https://github.com/grpc-ecosystem/grpc-gateway

grpc-gateway 會建立一個 reverse proxy server 把 gRPC 服務轉換成 RESTful JSON API

轉成 RESTful API 之後，就可以使用 Postman 之類的工具測試寫好的服務了

### 1. 要安裝的 plugin

```bash
go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
```

### 2. proto 檔案增加 RESTful option

就是把 RESTful 的 router 寫進來

```proto
syntax = "proto3";

package proto;

import "google/api/annotations.proto";

message EchoMessage {
  string value = 1;
}

service EchoService {
  rpc Echo (EchoMessage) returns (EchoMessage) {
    option (google.api.http) = {
        post: "/echo/echo"
        body: "*"
    };
  }
}
```

### 3. 產生 pb.go, pb.gw.go

```bash
protoc -I/usr/local/include -I. \
    -I$(GOPATH)/src \
    -I$(GOPATH)/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
    --go_out=plugins=grpc:. proto/*.proto
protoc -I/usr/local/include -I. \
    -I$(GOPATH)/src \
    -I$(GOPATH)/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
    --grpc-gateway_out=logtostderr=true:. proto/*.proto
```

### 4. 寫 reverse proxy 的進入點

把 gRPC 服務加入 proxy 裡面

```go
func gatewayServer() {
	fmt.Println("RESTful echo server :9999")
	grpcAddr := "localhost:8888"
	ctx := context.Background()
	ctx, cancel := context.WithCancel(ctx)
	defer cancel()

	mux := runtime.NewServeMux()
	opts := []grpc.DialOption{grpc.WithInsecure()}
	err := pb.RegisterEchoServiceHandlerFromEndpoint(ctx, mux, grpcAddr, opts)
	if err != nil {
		log.Fatalf("can not register endpoint %v", err)
	}

	http.ListenAndServe(":9999", mux)
}
```

### 5. 實測

```bash
$ curl -X POST http://localhost:9999/echo/echo -H 'Content-Type: application/json' -d '{ "value": "hi, how are you?" }'
{"value":"echo:hi, how are you?"}
```

## 小結

- 這邊才剛開始摸 gRPC，對他底層的運作方式還不是很熟
- proto 檔案類似 router
- 要實作的 server interface 類似 controller
- 有 gateway 可以轉成 RESTful API 讓測試更方便了
- 一些 server 的設定還要花時間微調

---

### Reference

- [grpc /](https://grpc.io/docs/tutorials/basic/go.html)
- [Protocol Buffers  |  Google Developers](https://developers.google.com/protocol-buffers/)
- [API 文件就是你的伺服器，REST 的另一個選擇：gRPC](https://yami.io/grpc/)
- [grpc-gateway | gRPC to JSON proxy generator following the gRPC HTTP spec](https://grpc-ecosystem.github.io/grpc-gateway/)
