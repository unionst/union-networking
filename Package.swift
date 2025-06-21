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
        .package(path: "../union-keychain"),
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

