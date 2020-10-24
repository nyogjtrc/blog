---
title: "軟體開發原則: DRY, KISS, YAGNI"
date: 2020-05-11T02:39:34+08:00
tags: [programming, principle]
---

最近在 `code review` 時，看到不少讓人頭暈的程式碼

在討論如何寫出更好的程式碼之外，應該要回顧幾個軟體開發原則，避免自己走歪路

## DRY

wiki: https://en.wikipedia.org/wiki/Don%27t_repeat_yourself

原文: `Don't repeat yourself`，如同字面上的意思，不要重複你的程式碼。

最直接的例子就是在開發程式時，不想思考跟設計，直接使用複製貼上。

這種方式看似可以很快的產出程式碼，實際上只會變成你的拌腳石。
當你遇到要修改的時候，複製貼上的次數就會變成工作時間的倍數。

##### Example

當你會重複的使用某個 function 時

```php
<?php

function hello($message)
{
    echo $message;
}

hello("hey");
hello("google");

hello("hi");
hello("siri");
```

請善用 for loop

```php
<?php

function hello($message)
{
    echo $message;
}

foreach (["hey", "google"," hi", "siri"] as $message) {
    hello($message);
}
```

## KISS

wiki: https://en.wikipedia.org/wiki/KISS_principle

原文: Keep It Simple, Stupid，意思是要化繁為簡，保持程式碼簡單。

足夠直白簡單的程式碼，讓其他人容易閱讀、理解跟維護。

##### Example

經典的波動拳程式碼 (我想故意寫寫看，還會寫不太出來…

```php
<?php

if (!is_null($cat)) {
    if (!empty($cat)) {
        if (!is_array($cat)) {
            if (!is_boy($cat)) {
                if (is_orange($cat)) {
                    // is good cat ...?
                }
            }
        }
    }
}
```

設計一或多個 function 把條件分類，並且優先排除不附合條件的資料

```php
<?php

function is_cat($cat) {
    if (empty($cat)) {
        return false
    }
    if (is_array($cat)) {
        return false
    }
    return true
}

function good_cat($cat) {
    if (!is_cat($cat)) {
        return false
    }

    if (is_boy($cat)) {
        return false
    }

    if (!is_orange($cat)) {
        return false
    }
    return true
}
```


## YAGNI

wiki: https://en.wikipedia.org/wiki/You_aren%27t_gonna_need_it

原文: You aren’t gonna need it，你不會需要它

不要預先寫一些還用不到的程式，只有在你需要用到時，才寫程式。
在你不知道接下來的程式會需要怎麼樣改動的情況下，多餘的設計是沒有必要的。

你可能會運用過去的經驗，來評估程式未來的走向，做一些預測的設計。
但是這些設計，很有可能派不上用場，也等於了你白白的浪費時間。

說到這邊，一定會有人說，那是不是只要完成需求規格，其他就不管了？這樣反而是誤用了這個原則。
只要程式還有人在使用，就一定會有一個基礎的標準要滿足。

YAGNI 原則是希望你不要過早的去優化程式碼。

## 小結

太過執著於特定的原則，可能會落入過度設計 (Over Engineering) 或是不求甚解的狀況。

了解這些軟體開發原則並且適當的運用在程式開發上，有助於設計出更加優美的程式。


---

#### Reference

- [程式設計心法 避免重複原則（DRY principle） | 璇之又璇的網路世界](https://shawnlin0201.github.io/Methodology/Methodology-001-DRY-principle/)
- [料理秘方 KISS，Keep it simple, stupid | 軟體主廚的程式料理廚房 - 點部落](https://dotblogs.com.tw/supershowwei/2017/02/14/175826)
