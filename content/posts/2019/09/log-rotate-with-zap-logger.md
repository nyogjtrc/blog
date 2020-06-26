---
title: "Log Rotate With Zap Logger"
date: 2019-09-23T23:53:18+08:00
tags: [go, logger]
---

github.com/uber-go/zap, zap 是目前我比較常用的 logger package

在寫 log file 時，通常需要定期的封存檔案，避免單一檔案過大而導致之後難以整理

zap 本身沒有 rotation 功能，要自己寫，或是用 lumberjack 這個 package

zap 官方的 FAQ 中 [zap/FAQ.md](https://github.com/uber-go/zap/blob/master/FAQ.md#does-zap-support-log-rotation)

就有一個基本的 example

```go
w := zapcore.AddSync(&lumberjack.Logger{
    Filename:   "/var/log/myapp/foo.log",
    MaxSize:    500, // megabytes
    MaxBackups: 3,
    MaxAge:     28, // days
})
core := zapcore.NewCore(
    zapcore.NewJSONEncoder(zap.NewProductionEncoderConfig()),
    w,
    zap.InfoLevel,
)
logger := zap.New(core)
```

如果要設定成把 log message 同時寫到檔案跟畫面的話，則要使用使用 zapcore.NewMultiWriteSyncer(...)

```go
writeFile := zapcore.AddSync(&lumberjack.Logger{
    Filename: "service.log",
    MaxSize:  10, // megabytes
    MaxAge:   28, // days
})
writeStdout := zapcore.AddSync(os.Stdout)

core := zapcore.NewCore(
  zapcore.NewJSONEncoder(zap.NewProductionEncoderConfig()),
  zapcore.NewMultiWriteSyncer(writeFile, writeStdout),
  zap.InfoLevel,
)

logger := zap.New(core)
```

上面設定的 logger 會缺少 caller 跟 stack trace 的資訊，需要再加入 options

```go
logger := zap.New(
    core,
    zap.AddCaller(),
    zap.AddStacktrace(zap.ErrorLevel),
)
```
