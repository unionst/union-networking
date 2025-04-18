// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "union-networking",
    platforms: [
        .macOS(.v13),
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "UnionNetworking",
            targets: ["UnionNetworking"]
        ),
    ],
    targets: [
        .target(
            name: "UnionNetworking"
        ),
    ]
)
