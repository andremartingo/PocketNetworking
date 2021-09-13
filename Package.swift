// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "pocketnetworking",
    platforms: [.iOS(.v15), .macOS(.v12), .tvOS(.v15)],
    products: [
        .library(
            name: "pocketnetworking",
            targets: ["pocketnetworking"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "pocketnetworking",
            dependencies: []),
        .testTarget(
            name: "pocketnetworkingTests",
            dependencies: ["pocketnetworking"]),
    ]
)
