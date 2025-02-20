// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "http2",
    platforms: [.macOS(.v10_14)],
    products: [
        .executable(name: "App", targets: ["App"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-certificates.git", from: "1.0.0"),
        .package(url: "https://github.com/hummingbird-project/hummingbird-core.git", from: "1.0.0"),
        .package(url: "https://github.com/hummingbird-project/hummingbird.git", from: "1.0.0"),
        .package(url: "https://github.com/hummingbird-project/hummingbird-xct-async-http-client.git", from: "0.1.0"),
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "App",
            dependencies: [
                .product(name: "Hummingbird", package: "hummingbird"),
                .product(name: "HummingbirdHTTP2", package: "hummingbird-core"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
            swiftSettings: [
                // Enable better optimizations when building in Release configuration. Despite the use of
                // the `.unsafeFlags` construct required by SwiftPM, this flag is recommended for Release
                // builds. See <https://github.com/swift-server/guides#building-for-production> for details.
                .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release)),
            ]
        ),
        .testTarget(
            name: "AppTests",
            dependencies: [
                .byName(name: "App"),
                .product(name: "X509", package: "swift-certificates"),
                .product(name: "HummingbirdXCT", package: "hummingbird"),
                .product(name: "HBXCTAsyncHTTPClient", package: "hummingbird-xct-async-http-client"),
            ]
        ),
    ]
)
