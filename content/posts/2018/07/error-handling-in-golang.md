---
title: "Error Handling in Golang"
date: 2018-07-26T15:50:07+08:00
tags: []
draft: true
---

## golang 原生的 error type

golang 的 error interface

```
type error interface {
    Error() string
}
```

實作 Error() 方法，就會是 error type，例如 os package 裡面的 PathError

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

## 建立自己的 app error struct

依照使用情境設計 strcut

### api error

data: code, message, sub error

method: output, trace log

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
```

```
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

### api gateway error

data: code, message, internal code

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
