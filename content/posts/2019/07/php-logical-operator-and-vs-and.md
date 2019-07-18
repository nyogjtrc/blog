---
title: "php 的邏輯運算子  and vs &&"
date: 2019-07-19T01:01:55+08:00
tags: [php]
---

## 邏輯運算子

php 的邏輯運算子除了 && 跟 || 之外，還有 and 跟 or

他們之間的差異在有不同的優先順序 [Precedence](https://www.php.net/manual/en/language.operators.precedence.php)

而這個優先順序上的差異，會讓程式在一些情況下，產生跟你想像的不一樣的成果

### 使用 &&

```php
<?php

$a = true && false;

// equal
$a = (true && false);

// $a: false
```

### 使用 and

```php
<?php

$a = true and false;

// equal
($a = true) and false;

// $a: true
```

"=" 優先順序高於 "and" "or"

## and 跟 or 的其他用途

```php
<?php

do_something() and success() or failure();
```

do_something() 成功的話會執行 success()，失敗的話會執行 failure()

類似 bash 中常見的用法

```sh
$ cmd1 && cmd2 || cmd3

$ test -d ./project || mkdir ./project
```

### Reference

- https://stackoverflow.com/questions/5998309/logical-operators-or-or
- https://www.php.net/manual/en/language.operators.precedence.php
- https://stackoverflow.com/questions/2803321/and-vs-as-operator
