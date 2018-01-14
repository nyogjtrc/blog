---
title: "在 Linux 上處理圖檔"
date: 2017-04-15T01:09:42+08:00
tags: [Linux]

---

想要在 Linux 上處理圖檔，我一開始想到的是 GIMP，但是這個軟體巨大到不太想專程去安裝，於是開始尋找其他輕量一點的工具

可以直接在 command line 上處理圖檔的工具:
**convert**

convert 功能之多，我剛看到時也嚇了一下，可以轉換檔案格式，可以縮放圖片，可以使用濾鏡，可以旋轉圖片等等。不過有沒有比較輕量我也不太清楚，至少我可以快速的得到我要的結果。

## 使用範例

把 png 檔轉成 jpg 檔
```bash
$ convert image.png image.jpg
```

轉 90 度
```bash
$ convert image.jpg -rotate 90 modified-image.jpg
```

調整圖片壓縮品質
```bash
$ convert image.jpg -quality 50 modified-image.jpg
```

把所有圖片調整成高度 200
```bash
$ for file in *.jpg; do convert "$file" -resize x200 "s-$file"; done
```

在圖片上寫字

```bash
$ convert image.jpg -font courier -fill white -pointsize 20 -annotate +50+50 'Writing' write-image.jpg
```

### Reference

- [5 ImageMagick command line examples – part 1](http://www.ioncannon.net/linux/81/5-imagemagick-command-line-examples-part-1/)
- [Command-line Tools: Convert @ ImageMagick](https://www.imagemagick.org/script/convert.php)
- [How to Quickly Resize, Convert & Modify Images from the Linux Terminal](https://www.howtogeek.com/109369/how-to-quickly-resize-convert-modify-images-from-the-linux-terminal/)
