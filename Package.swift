// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "union-networking",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "UnionNetworking",
            targets: ["UnionNetworking"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/unionst/union-keychain.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "UnionNetworking",
            dependencies: [
                .product(name: "UnionKeychain", package: "union-keychain")
            ]
        ),
    ]
)

