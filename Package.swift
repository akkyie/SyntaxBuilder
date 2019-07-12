// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "SyntaxBuilder",
    platforms: [.macOS(.v10_15)],
    products: [
        .executable(name: "example", targets: ["Example"]),
        .library(name: "SyntaxBuilder", targets: ["SyntaxBuilder"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", .exact("0.50000.0")),
        // .package(url: "https://github.com/apple/swift-syntax.git", .revision("xcode11-beta1")),
    ],
    targets: [
        .target(
            name: "Example",
            dependencies: ["SyntaxBuilder"]
        ),
        .target(
            name: "SyntaxBuilder",
            dependencies: ["SwiftSyntax"]
        ),
    ]
)
