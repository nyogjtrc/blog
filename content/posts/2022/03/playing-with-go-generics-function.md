---
title: "玩看看 go 的泛型函數 (Generics Function)"
date: 2022-03-29T01:50:18+08:00
tags: [go]
---

在 2022-03-22 這天 Go 正式發佈 1.18 版了！
這個版本其中一大特色就是增加了社群討論許久的`泛型(Generics)`

今天來玩看看 go 的`泛型函數(Generics Function)`

## 沒有泛型

我們來寫一個尋找 slice 資料索引的 function

在沒有使用泛型的情況下，處理一種類別就要寫一個 function

```go
func FindIndexInt(x []int, y int) (int, error) {
	for k := range x {
		if y == x[k] {
			return k, nil
		}
	}
	return -1, errors.New("Not found")
}

func FindIndexString(x []string, y string) (int, error) {
	for k := range x {
		if y == x[k] {
			return k, nil
		}
	}
	return -1, errors.New("Not found")
}
```

依照類別的不同，自己選擇對應的 function
```go
fmt.Println("FindIndexInt()")
fmt.Println(FindIndexInt([]int{9, 8, 7, 6, 5}, 9))
fmt.Println(FindIndexInt([]int{9, 8, 7, 6, 5}, 6))
fmt.Println(FindIndexInt([]int{9, 8, 7, 6, 5}, 10))

fmt.Println("FindIndexString()")
fmt.Println(FindIndexString([]string{"x", "y", "z"}, "z"))
fmt.Println(FindIndexString([]string{"x", "y", "z"}, "a"))
```

輸出結果
```bash
FindIndexInt()
0 <nil>
3 <nil>
-1 Not found

FindIndexString()
2 <nil>
-1 Not found
```

## 使用泛型

使用泛型讓 function 可以一次支援多種的類別，我們需要在宣告 function 時，增加類別參數(type parameters)。此外，因為會使用到 `==` 比對資料，所以要把類別限制為 `comparable`。

`comparable` 是 1.18 新增的類別，專門用在泛型的類別約束(type constraint)，代表所有可以使用 `==` 或 `!=` 做比較的類別

將程式改寫如下:
```go
func FindIndex[T comparable](x []T, y T) (int, error) {
	for k := range x {
		if y == x[k] {
			return k, nil
		}
	}
	return -1, errors.New("Not found")
}
```

將不同類別的資料代入 function
```go
fmt.Println("FindIndex[T comparable]() with int slice")
fmt.Println(FindIndex([]int{9, 8, 7, 6, 5}, 9))
fmt.Println(FindIndex([]int{9, 8, 7, 6, 5}, 6))
fmt.Println(FindIndex([]int{9, 8, 7, 6, 5}, 10))

fmt.Println("FindIndex[T comparable]() with string slice")
fmt.Println(FindIndex([]string{"x", "y", "z"}, "z"))
fmt.Println(FindIndex([]string{"x", "y", "z"}, "a"))
```

我們會拿到一樣的結果
```bash
FindIndex[T comparable]() with int slice
0 <nil>
3 <nil>
-1 Not found

FindIndex[T comparable]() with string slice
2 <nil>
-1 Not found
```

## 總結

這是一個泛型的小試身手，翻了翻目前官方提供的教學中，function 的應用應該是最簡單好懂的。其他泛型的應用有一點眼花撩亂，等我看懂了再繼續寫。

## Reference

- https://go.dev/blog/go1.18
- https://go.dev/doc/tutorial/generics
- https://go.dev/blog/intro-generics
