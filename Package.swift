// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NicosiaApp",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "NicosiaApp",
            targets: ["NicosiaApp"]),
    ],
    dependencies: [
        // Add your dependencies here
        // Example:
        // .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.0.0"),
    ],
    targets: [
        .target(
            name: "NicosiaApp",
            dependencies: []),
        .testTarget(
            name: "NicosiaAppTests",
            dependencies: ["NicosiaApp"]),
    ]
)