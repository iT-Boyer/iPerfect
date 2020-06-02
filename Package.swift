// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
let base = "https://github.com/PerfectlySoft"
let itboyer = "https://github.com/it-boyer"

let versions:Version = "3.0.0"  //Version(0,0,0)..<Version(10,0,0)
let urls = [
    "\(base)/Perfect-HTTPServer.git", // 最基本的服务器核心依赖
    "\(base)/Perfect-MySQL.git", // MySQL服务器
    "\(base)/Perfect-Logger.git", // 日志处理库
    "\(base)/Perfect-RequestLogger.git", // 请求日志处理库
    "\(base)/Perfect-WebSockets.git",
    "\(base)/Perfect-Markdown.git",
    "\(base)/Perfect-Notifications.git",
//    "\(itboyer)/Perfect-Turnstile-SQLite.git",
    "\(base)/Perfect-CURL.git",
    "https://github.com/iamjono/JSONConfig.git",
//    "\(base)/Perfect-libcurl.git",
    "https://github.com/SwiftORM/MySQL-StORM.git",
//    "https://github.com/iT-Boyer/Perfect-Turnstile-MySQL.git",
//    "https://github.com/rymcol/SwiftSQL.git"
]




let package = Package(
    name: "iPerfect",
    products:[
//        .library(name: "iPerfect", targets: ["iPerfect"]),
//        .library(name: "Perfect-JSON-API", targets: ["Perfect-JSON-API"]),
        //.library(name: "OnLineMDEditor", targets: ["OnLineMDEditor"])
    ],
    dependencies: urls.map { .package(url: $0, from: versions) },
    targets: [
        .target(
            name: "iPerfect",
            dependencies: ["PerfectHTTPServer"]),
        .testTarget(
            name: "iPerfectTests",
            dependencies: ["iPerfect"]),
        ///JSON API服务
        .target(name:"Perfect-JSON-API",
               dependencies: ["PerfectHTTPServer"],
               path:"Other/JSONAPI/Sources"
               ),
        ///在线MarkDown编辑器
        .target(name:"OnLineMDEditor",
                dependencies: ["PerfectHTTPServer","PerfectWebSockets","PerfectMarkdown"],
                path:"Other/OnlineMDEditor",
                sources:["Sources"]),
        ///推送
        .target(name:"Perfect-APNS",
                dependencies: ["PerfectHTTPServer","PerfectNotifications"],
                path:"Other/Perfect-APNS",
                exclude:["Perfect News"],
                sources:["Backend/Sources"]),
        ///SQLite
//        .target(name:"TurnstileSQLiteDemo",
//                dependencies:["PerfectTurnstileSQLite"],
//                path:"Other/TurnstileSQLiteDemo",
//                exclude:["webroot"],
//                sources:["Sources"]),
        ///天气预报
        .target(name:"Perfect-Weather",
                dependencies:["PerfectCURL","JSONConfig",],//"cURL"],
                path:"Other/PerfectWeather",
                exclude:["Resource","Tests"],
                sources:["Sources"]),
        ///TODO
//        .target(name:"ToDO-Backend",
//                dependencies:[.target(name: "ToDo-API"),.target(name: "Perfect-ToDo-iOS-DemoTests"),],
//                path:"Other/ToDO-Backend",
//                exclude:["Perfect-ToDo-iOS",
//                         "Perfect-ToDo-API/Supporting"]),
//        .testTarget(
//                    name: "Perfect-ToDo-iOS-DemoTests",
//                    dependencies:[.target(name: "ToDo-API"),],
//                    path:"Other/ToDO-Backend/Perfect-ToDo-API/Tests",
//                    sources:["Perfect-ToDo-iOS-DemoTests"]),
//        .target(name: "ToDo-API",
//                dependencies: [.target(name: "ToDoModel"),],
//                path:"Other/ToDO-Backend/Perfect-ToDo-API/Sources/ToDo-API"),
//        .target(name: "ToDoModel",
//                dependencies:["MySQLStORM","PerfectTurnstileMySQL","SwiftSQL"],
//                path:"Other/ToDO-Backend/Perfect-ToDo-API/Sources/ToDoModel")
    ]
)
