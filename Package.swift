// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
let base = "https://github.com/PerfectlySoft"
let package = Package(
    name: "iPerfect",
    products:[
//        .library(name: "iPerfect", targets: ["iPerfect"]),
//        .library(name: "Perfect-JSON-API", targets: ["Perfect-JSON-API"]),
        //.library(name: "OnLineMDEditor", targets: ["OnLineMDEditor"])
    ],
    dependencies: [
        .package(url: "\(base)/Perfect-HTTPServer.git", from: "3.0.12"),
        ///Markdown在线编译器
        .package(url: "\(base)/Perfect-WebSockets.git", from:"3.0.0"),
        .package(url: "\(base)/Perfect-Markdown.git", from: "3.0.0"),
        ///远程通知
        .package(url: "\(base)/Perfect-Notifications.git", from:"3.0.0"),
        ///Sqlite
        .package(url: "\(base)/Perfect-Turnstile-SQLite.git", from: "3.0.0"),
        //天气demo
        .package(url: "\(base)/Perfect-CURL.git", from: "3.0.0"),
        .package(url: "https://github.com/iamjono/JSONConfig.git", from: "3.0.0"),
//        .package(url: "\(base)/Perfect-libcurl.git", from: "3.0.0"),
//        ///TODO
        .package(url: "https://github.com/SwiftORM/MySQL-StORM.git", from: "3.0.0"),
        .package(url: "\(base)/Perfect-Turnstile-MySQL.git", from: "3.0.0"),
        .package(url: "https://github.com/rymcol/SwiftSQL.git", from: "0.0.0"),
    ],
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
        .target(name:"TurnstileSQLiteDemo",
                dependencies:["PerfectTurnstileSQLite"],
                path:"Other/TurnstileSQLiteDemo",
                exclude:["webroot"],
                sources:["Sources"]),
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
        .testTarget(
                    name: "Perfect-ToDo-iOS-DemoTests",
                    dependencies:[.target(name: "ToDo-API"),],
                    path:"Other/ToDO-Backend/Perfect-ToDo-API/Tests",
                    sources:["Perfect-ToDo-iOS-DemoTests"]),
        .target(name: "ToDo-Backend/ToDo-API",
                dependencies: [.target(name: "ToDoModel"),],
                path:"Other/ToDO-Backend/Perfect-ToDo-API/Sources/ToDo-API"),
        .target(name: "ToDo-Backend/ToDoModel",
                dependencies:["MySQLStORM","PerfectTurnstileMySQL","SwiftSQL"],
                path:"Other/ToDO-Backend/Perfect-ToDo-API/Sources/ToDoModel")
    ]
)
