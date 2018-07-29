---
title: "Error Handling in Golang"
date: 2018-07-26T15:50:07+08:00
tags: [golang, error]
---

## Golang 原生的 Error Type

先認識 golang 的 error interface

```
type error interface {
    Error() string
}
```

只要 struct 實作 Error() 方法，就會是 error type，例如 os package 裡面的 PathError

https://golang.org/pkg/os/#PathError

```
// PathError records an error and the operation and file path that caused it.
type PathError struct {
	Op   string
	Path string
	Err  error
}

func (e *PathError) Error() string { return e.Op + " " + e.Path + ": " + e.Err.Error() }
```

## 建立自己程式裡的 Error struct

依照使用情境 error strcut  

### RESTful API Error

RESTful API 除了訊息之後，要幫各種情況的錯誤加上編號，方便程式做後續的應對

並可以把其他來源的錯誤一並放入，方便追蹤錯誤

strcut fields: code, message, error

example:

```
// AppError struct with code and message
type AppError struct {
	code    int
	message string
	err     error
}

// New create Error instance
func New(code int, message string, err error) *AppError {
	return &AppError{code, message, err}
}

// Error getter
func (e *AppError) Error() string {
	return fmt.Sprintf("%d: %s", e.code, e.message)
}

// Code getter
func (e *AppError) Code() int {
	return e.code
}

// Message getter
func (e *AppError) Message() string {
	return e.message
}

// ErrorSummry getter
func (e *AppError) ErrorSummry() string {
	return fmt.Sprintf("%d: %s, [%s]", e.code, e.message, e.err.Error())
}
```

### API Gateway Error

Gateway 公開提供服務在網路上，有時候會有安全性的需要，要隱藏一些內部錯誤訊息

但是維運上還是會需要有足夠的資訊來了解服務當下的狀況，可以放一個內部的代碼，多一點線索

strcut fields: code, message, internal code

example:

```
// Error for gateway
type Error struct {
	code      int
	message   string
	interCode int
}

// New Error instance
func New(code int, message string, interCode int) *Error {
	return &Error{code, message, interCode}
}

// Error getter
func (e *Error) Error() string {
	return fmt.Sprintf("%d: %s (%d)", e.code, e.message, e.interCode)
}
```

### Full Example

https://github.com/nyogjtrc/practice-go/tree/master/error-code


### Reference

- https://blog.golang.org/error-handling-and-go
- https://medium.com/@sebdah/go-best-practices-error-handling-2d15e1f0c5ee
