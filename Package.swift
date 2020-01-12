// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DangerXCodeSummary",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "DangerXCodeSummary",
            targets: ["DangerXCodeSummary"]),
//        .library(name: "DangerDeps", type: .dynamic, targets: ["DangerDependencies"]) // dev
    ],
    dependencies: [
        .package(url: "https://github.com/danger/swift", from: "3.0.0"),
//        .package(url: "https://github.com/f-meloni/Rocket", from: "1.0.0"), // dev
    ],
    targets: [
//        .target(name: "DangerDependencies",dependencies: ["Danger", "DangerXCodeSummary"]), //dev
        .target(
            name: "DangerXCodeSummary",
            dependencies: ["Danger"]),
        .testTarget(
            name: "DangerXCodeSummaryTests",
            dependencies: ["DangerXCodeSummary", "DangerFixtures"]),
    ]
)
