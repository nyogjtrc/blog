---
title: "試用 GORM"
date: 2020-08-05T00:39:46+08:00
tags: [go]
---

## ORM (Object Relational Mapping)

ORM 是一種把 **資料庫** 對應到 **程式物件** 的技術，可以讓開發者更快速的開發處理資料庫的程式

使用上常見優點：
- 快速開發
- 較高的安全性

也是有相對的缺點：
- 犧牲效能
- 額外的學習成本
- 難以處理複雜查詢

這次看在優點上，小試了一下 Go 裡面的 ORM 工具

## GORM

GORM 是 Go 裡面熱門的 ORM 套件之一

ps. 我練習的程式碼在此 https://github.com/nyogjtrc/practice-go/tree/master/using-gorm

## 定義資料表結構

我們要建立一個 Product 的 table 如下

```go
// Product _
type Product struct {
	ID        uint   `gorm:"primary_key"`
	Code      string `gorm:"not null;unique_index"`
	Price     uint
	CreatedAt time.Time
	UpdatedAt time.Time
}
```

- struct 的 field 會直接對應到 table 欄位
- 有需要微調結構的話，可以透過 **gorm** 這個 tag 定義
	- 例如要建立 unique index 的話，就加上 `unique_index`

## Migrate

GORM 有一套 Migrate 工具

如果要寫測試的話 AutoMigrate() 是個簡單的工具，不過官方有提醒這個 function 不適合用在 Production 上

```go
// Migrate the schema
db.AutoMigrate(&Product{})

// Drop table
db.DropTable(Product{})
```

## CRUD

### Create

```go
// Create
err = db.Create(&Product{Code: "L1212", Price: 1000}).Error
if err != nil {
	panic(err)
}

err = db.Create(&Product{Code: "L1234", Price: 1234}).Error
if err != nil {
	panic(err)
}
```

### Read

查詢有 First(), Find() 等等的方法，也有跟 SQL 一樣用法的 Where()

```go
// Read
var products []Product
var product Product

// find product with id 1
if err := db.Find(&products).Error; err != nil {
	fmt.Println("error", err)
}
fmt.Println(products)

// find product with code l1212
if err := db.Where("code = ?", "L1212").First(&product).Error; err != nil {
	panic(err)
}

fmt.Println("product", product)
```

### Update
```go
// Update - update product's price to 2000
db.Model(&product).Update("Price", 2000)
fmt.Println("product", product)
```

### Delete
```go
// Delete - delete product
err = db.Debug().Delete(Product{}).Error
if err != nil {
	panic(err)
}
```

如果需要查看 GORM 實際執行的 SQL，可以使用 Debug() 方法

Debug() 會把 SQL 資訊輸出到 terminal 上

```
[2020-08-05 00:26:18]  [3.83ms]  DELETE FROM `products`
[2 rows affected or returned ]
```


### Reference

- http://gorm.io/docs/
