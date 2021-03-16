---
title: "Interface in Go"
date: 2021-03-16T21:13:05+08:00
tags: [go]
---

## Interface

Go 的 interface (介面) 是一堆方法簽章集合而成的 type (型態)，
只要一個 type 實作出 interface 定義的所有方法，就是實作 interface

interface 是 Go 用來定義物件行為的方式，其概念是：

> 如果某個物件可以做「這件事」，那麼它就可以用來當成是「這種東西」。

> (if something can do this, then it can be used here.)

看看以下範例

```go
type Shape interface {
	Area() float64
}

type Rectangle struct {
	Width, Height float64
}

func (r Rectangle) Area() float64 {
	return r.Width * r.Height
}

type Circle struct {
	Radius float64
}

func (c Circle) Area() float64 {
	return math.Pi * c.Radius * c.Radius
}

func printArea(shape Shape) {
	fmt.Println("area:", shape.Area())
}

func main() {
	r := Rectangle{Width: 7, Height: 8}
	c := Circle{Radius: 5}

	printArea(r) // output: area: 56
	printArea(c) // output: area: 78.53981633974483
}
```

我們定義了 Shape interface，只要實作 Shape 定義的方法 Area() 就是實作 Shape

而 Rectangle 跟 Circle 兩個 struct 都有實作出 Area()，所以都符合 Shape interface

所以都可以使用 printArea() 印出結果

## Implicit Interface

跟其他程式語言不太一樣的地方是 Go 的 interface 是 implicit interface，
不需要使用 **implements** 關鍵字實作，只要設計好對應的方法就可以達成實作

這個特性增加了 interface 使用上的彈性
- 程式不會在實作 interface 時跟任何的 package 相依
- 一個 type 可以實作多個 interface

看看以下範例
```go
type Rectangle struct {
	Width, Height float64
}

func (r Rectangle) Area() float64 {
	return r.Width * r.Height
}

func (r Rectangle) Info() string {
	return fmt.Sprintf("w: %f, h: %f, a: %f", r.Width, r.Height, r.Area())
}

type Information interface {
	Info() string
}

func printInfo(i Information) {
	fmt.Println(i.Info())
}

func main() {
	r := Rectangle{Width: 7, Height: 8}

	printArea(r) // output: area: 56
	printInfo(r) // output: w: 7.00, h: 8.00, a: 56.00
}
```

我們增加了 Information interface，並且在 Rectangle 藉由實作 Info() 方法來實作 Information interface

現在 Rectangle 同時實作了 Shape 跟 Information interface

## Empty Interface

當 interface 不包含任何方法時，稱之為 empty interface (空介面)

空介面可以裝入任何型態的數值，因為每一種型態都會實作至少 0 個方法

如果要存取 empty interface 的數值時，可以使用 type assertion 或是 type switch

看看以下範例

```go
// 宣告 a 為 empty interface
var a interface{}

// 放入任意數值
a = 5
a = "xyz"

// type assertion
s, ok = a.(string)
fmt.Println(s, ok) // output: xyz true

// type switch
switch v := a.(type) {
case string:
	fmt.Printf("type string: %s\n", v)
case int:
	fmt.Printf("type int: %d\n", v)
}
// output: type string: xyz

```

其實官網的教學 [A Tour of Go](https://tour.golang.org/) 都有說明

---

### Reference

- [A Tour of Go - Interfaces](https://tour.golang.org/methods/9)
- [有效地去 - Effective go 正體中文翻譯 - 程式、雜談](https://ronmi.github.io/post/go/effectivego/)
- [Effective Go - Interfaces and other types](https://golang.org/doc/effective_go#interfaces_and_types)
- [Go interface - working with interfaces in Golang](https://zetcode.com/golang/interface/)
- [解釋 Golang 中的 Interface 到底是什麼 – 電腦玩瞎咪](https://yami.io/golang-interface/)

