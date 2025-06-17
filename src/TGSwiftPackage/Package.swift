// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TGSwiftPackage",
    platforms: [
        .iOS(.v12),
    ],
    products: [
        .library(
            name: "TGSwiftPackage",
            targets: ["TGSwiftPackage"]),
    ],
    dependencies: [
        .package(url: "https://github.com/AFNetworking/AFNetworking.git", .upToNextMajor(from: "4.0.0")),
        
        .package(url: "https://github.com/ccgus/fmdb",        .upToNextMinor(from: "2.7.8")),
        .package(url: "https://github.com/AFNetworking/AFNetworking.git", .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/CoderMJLee/MJExtension", .upToNextMajor(from: "3.4.0")),
        .package(url: "https://github.com/jpsim/Yams.git", from: "5.0.6"),
        .package(url: "https://github.com/CoderMJLee/MJRefresh.git", from: "2.0.6"),
        .package(url: "https://github.com/ReactiveCocoa/ReactiveCocoa.git", from: "1.0.0"),
        .package(url: "https://github.com/ReactiveCocoa/ReactiveSwift.git", from: "1.0.1"),
    ],
    targets: [
        .target(
            name: "TGSwiftPackage",
            dependencies: ["AFNetworking"]
        ),
        .testTarget(
            name: "TGSwiftPackageTests",
            dependencies: ["TGSwiftPackage"]
        )
    ]
)

