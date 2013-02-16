OPENSYUS
========

本项目为 opensysu 的主页代码。

Structures
----------

``` bash
$ tree .
.
├── css
├── feed
├── images
├── jekyll                # jekyll 目录
│   ├── _includes
│   ├── _layouts
│   ├── _posts
│   ├── _site             # 生成的静态文件
│   │   ├── css
│   │   ├── feed
│   │   └── images
│   │
│   ├── css
│   ├── feed
│   ├── images
│   ├── media
│   │   └── images
│   └── tag
└── media
    └── images
```


Workflows
---------

1. `make server` 运行 jekyll，更新网站
2. 更新完成后，`make deploy` 将 `_site` 目录下的文件复制到根目录
3. 提交更新到 github