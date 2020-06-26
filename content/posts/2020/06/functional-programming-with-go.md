---
title: "Functional Programming With Go"
date: 2020-06-26T15:58:41+08:00
tags: [functional programming, go]
---

Functional Programming 中文：函數式程式設計，是程式設計方法 (programming paradigm) 的其中一種

所謂的 Functional Programming 是以數學函數的概念來設計程式，並避免有狀態 (state) 與避免可變資料 (mutable data)

以下是一些 Functional Programming 的特點

## Pure functions (純函數)

函數會基於傳入的參數來回傳結果，不依懶全域變數

只要給一個 function 相同的傳入參數，就一定會得到相同的回傳結果，不會有任可的副作用 (side effects)

```go
// pure function
func add(a, b int) int {
	return a + b
}


// not pure function
var z int
func addFive(x int) {
	z += x
}
```


## First-class and Higher-order functions (一等公民，高階函數)

First-class 是指函數可以當做一種資料型別，好比直接賦值到變數中，存放到資料結構當中

Higher-order functions 是指函數可以當作參數傳遞或是其他函數的回傳值

```go
add := func(x, y int) int {
	return x + y
}

calculate := func(m, n int, f func(int, int) int) int {
	return f(m, n)
}

fmt.Println(calculate(1, 2, add))
```

## Recursion (遞迴)

Functional Programming 通常用遞迴來完成迭代

```go
func factorial(num int) int {
	if num == 0 {
		return 1
	}
	return num * factorial(num-1)
}

fmt.Println(factorial(5))
```

但是在現實情況下，考慮到效能問題，多數還是以迴圈 (loops) 為主

## Lazy evaluation (延遲執行)

Lazy evaluation 是指說程式只會在需要的時候才運行，可以提升程式的效能

Go 中有 closures, goroutines 跟 channels 可以達到 Lazy evaluation 的效果

```go
func adder() func(int) int {
	sum := 0
	return func(x int) int {
		sum += x
		return sum
	}
}

pos, neg := adder(), adder()
for i := 0; i < 10; i++ {
	fmt.Println(pos(i), neg(-2*i))
}

```


## 小結

尋找適合的場景善加運用 Functional programming，  
讓單元測試 (unit test) 更加容易，提高可維護性 (maintainable)

我自己會從復雜的運算中整理出一些純綷的邏輯，以 Functional programming 的方式實作

---

### Reference


- [Functional programming - Wikipedia](https://en.wikipedia.org/wiki/Functional_programming)
- [Functional Programming](https://l3x.github.io/golang-code-examples/2014/08/14/functional-programming.html)
- [7 Easy functional programming techniques in Go | Technorage](https://deepu.tech/functional-programming-in-go/)
- [前端工程研究：理解函式編程核心概念與如何進行 JavaScript 函式編程 | The Will Will Web](https://blog.miniasp.com/post/2016/12/10/Functional-Programming-in-JavaScript)
- [Functional Programming 函式程式設計 - Leon's Blogging](https://mgleon08.github.io/blog/2019/07/26/functional-programming)
- [思考函數編程(3)函數編程能做些什麼？ | iThome](https://ithome.com.tw/node/49122)
- [Principles of Functional Programming - DEV](https://dev.to/jamesrweb/principles-of-functional-programming-4b7c)
