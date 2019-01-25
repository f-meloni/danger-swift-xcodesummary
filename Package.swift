// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DangerXCodeSummary",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "DangerXCodeSummary",
            targets: ["DangerXCodeSummary"]),
        .library(name: "DangerDeps", type: .dynamic, targets: ["DangerXCodeSummary"]) // dev
    ],
    dependencies: [
        .package(url: "https://github.com/danger/swift", from: "1.0.0"),
        .package(url: "https://github.com/f-meloni/Rocket", from: "0.4.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "DangerXCodeSummary",
            dependencies: ["Danger"]),
        .testTarget(
            name: "DangerXCodeSummaryTests",
            dependencies: ["DangerXCodeSummary", "DangerFixtures"]),
    ]
)
