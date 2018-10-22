# iPerfect
## Perfect简介
{% github PerfectlySoft Perfect 60e44e4 width = 30% %}
目前比较流行服务端框架主要有`Vapor`、`Perfect`、`Kitura`和`Zewo`，他们各有长短，本人这次主要是使用`Perfect`来写的，因为`Perfect`的功能比较完善，在GitHub上具有1W+的星，而且有一个非常重要的原因提供了[Perfect 中文文档](https://github.com/PerfectlySoft/PerfectDocs/blob/master/README.zh_CN.md)。

Perfect 包括了您所期待的所有基本功能，包括`路由`、`websockets` 基于 HTTP 的网络套接字、`TLS`（SSL）通信加密、`Mustache` 模板和 `Markdown` 模板、`JSON` 结构化数据等等，以及全部其他所有 Swift 后台框架加在一起才有的 XML 结构化数据、苹果推送消息 `APNS`、`MqTT` 消息队列和 `SMTP` 邮件发送，甚至大数据也支持。Perfect 的数据库支持非常广泛，其**原生SQL驱动**包括 `MySQL`、`SQLite`、`PostgreSQL` 和 `MariaDB`，还支持 `MongoDB`、`Redis`、`CouchDB` 甚至还包括 `FileMaker`（苹果自己的数据库 Swift 都不支持，Perfect 反过来支持——译者注）。**Perfect** 据说还部分支持微软的 `ODBC`，即多种数据库的底层兼容界面——有点像 `ORM`，但是以 C 函数库为基础。提到 `ORM` 数据库对象关系自动化管理，**Perfect**有 `StORM` 并完整实现了 `PostgreSQL`、`MySQL`、`CouchDB` 和 `SQLite`。

[Perfect文档生成器](https://github.com/PerfectlySoft/PerfectDocGenerator)
## 搭建HTTP服务器
{% github huos3203 PerfectTemplate 20294e56 width = 30% %}
本章将引导您使用Swift和Perfect软件框架逐步设置一个简单的HTTP服务器。

### 创建Web应用
1. 新建一个文件夹保存项目文件：
```
$ mkdir iPerfect
$ cd iPerfect
```
2. 初始化项目，用`SPM`软件包管理器：
```
$ swift package init --type=executable
Creating executable package: iPerfect
Creating Package.swift
Creating README.md
Creating .gitignore
Creating Sources/
Creating Sources/iPerfect/main.swift
Creating Tests/
```
3. 配置依赖
打开`Package.swift`文件进行编辑：
该文件在要求Swift编译的最低版本为`3.0.0`，设置`target`编译依存库`PerfectHTTPServer`
``` swift
// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
name: "iPerfect",
    dependencies: [
        .package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", from: "3.0.0")
    ],
    targets: [
    .target(
        name: "iPerfect",
        dependencies: ["PerfectHTTPServer"]),
    ]
)
```
4. 编码
```
mkdir Sources
echo 'print("您好！")' >> Sources/iPerfect/main.swift
```
5. 编译和运行
现在项目就已经准备好，可以通过以下两个命令编译和运行：
```
swift build
.build/debug/iPerfect
```
成功之后，会打印：
```
你好！！！
```

## 设置**Perfect HTTPServer**服务器
### 注册路由和请求／响应句柄
打开`Sources/iPerfect/main.swift`文件，把内容替换为以下程序：
``` swift
import PerfectHTTP
import PerfectHTTPServer

// 注册路由和请求／响应句柄
var routes = Routes()
routes.add(method: .get, uri: "/") {
    request, response in
    response.setHeader(.contentType, value: "text/html")
    response.appendBody(string: "<html><title>Hello, world!</title><body>Hello, world!</body></html>")
    .completed()
}

do {
    // 启动HTTP服务器
    try HTTPServer.launch(.server(name: "www.example.ca", port: 8181, routes: routes))
} catch {
    fatalError("\(error)") // fatal error launching one of the servers
}
```
2. 编译运行
```
$ swift build
$ .build/debug/iPerfect
>>
[INFO] Starting HTTP server www.example.ca on :::8181

```
在浏览器上打开`http://127.0.0.1:8181/`
终止服务器：在终端控制台上用组合键`control-c`可以随时停止服务器。

## 使用Xcode调试服务器
生成**iPerfect.xcodeproj**
Swift软件包管理器（SPM）能够为您的项目`iPerfect`生成Xcode工程：
```
swift package generate-xcodeproj
```
### 递归编译设置
1. 设置递归编译项目目录中的所有`target`
打开`iPerfect.xcodeproj`，在`Library Search Paths`检索项目软件库中新增：
```
$(PROJECT_DIR) - Recursive
```
2. scheme运行在**My Mac**
在Xcode打开项目之后，选择可执行目标为 `My Mac`，并选择正确的Swift工具链。
3. 设置服务器的资源目录
为了使服务器能够访问您工程文件夹下的目录，比如html静态网页。
进入菜单命令 `Product > Scheme > Edit Scheme…`，设置工作目录 `Use Custom Working Directory` 为项目文件夹。 

现在您就可以在Xcode中运行调试您的服务器了.

