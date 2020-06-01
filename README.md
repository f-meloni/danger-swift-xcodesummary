# DangerXCodeSummary
A Danger-Swift plugin that adds build errors, warnings and unit tests results generated from xcodebuild to your Danger report

Inspired by [danger-xcode_summary](https://github.com/diogot/danger-xcode_summary)

![DangerXCodeSummary](Images/DangerXCodeSummary.png)

## Getting Started

- Install [xcpretty](https://github.com/supermarin/xcpretty) and 
[xcpretty-json-formatter](https://github.com/marcelofabri/xcpretty-json-formatter) 

### Install DangerSwiftCoverage
#### Swift Package Manager (More performant)
You can use a "full SPM" solution to install both `danger-swift` and `DangerXCodeSummary`.

- Add to your `Package.swift`:

```swift
// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    ...
    products: [
        ...
        .library(name: "DangerDeps", type: .dynamic, targets: ["DangerDependencies"]), // dev
        ...
    ],
    dependencies: [
        ...
        // Danger
        .package(name: "danger-swift", url: "https://github.com/danger/swift.git", from: "3.0.0"), // dev
        // Danger Plugins
        .package(name: "DangerXCodeSummary", url: "https://github.com/f-meloni/danger-swift-xcodesummary", from: "1.2.1"), // dev
        ...
    ],
    targets: [
        .target(name: "DangerDependencies", dependencies: ["danger-swift", "DangerXCodeSummary"]) // dev
        ...
    ]
)
```

- Add the correct import to your `Dangerfile.swift`:
```swift
import DangerXCodeSummary

let summary = XCodeSummary(filePath: "result.json")
```

- Create a folder called `DangerDependencies` on `Sources` with an empty file inside like [Fake.swift](Sources/DangerDependencies/Fake.swift)
- To run `Danger` use `swift run danger-swift command`
- (Recommended) If you are using SPM to distribute your framework, use [Rocket](https://github.com/f-meloni/Rocket), or similar to comment out all the dev depencencies from your `Package.swift`.
This prevents the dev dependencies to be downloaded and compiled with your framework.

#### Marathon
- Add this to your `Dangerfile.swift`

```swift
import DangerXCodeSummary // package: https://github.com/f-meloni/danger-swift-xcodesummary.git

let summary = XCodeSummary(filePath: "result.json")
```

- (Recommended) Cache the `~/.danger-swift` folder

## Run with SPM
DangerXCodeSummary can be used with SPM (this repo uses it on the Linux CI), but at the moment, if you use SPM, falining tests inline messages are not generated.
To generate the report run:

```bash
swift test | XCPRETTY_JSON_FILE_OUTPUT=result.json xcpretty -f `xcpretty-json-formatter`
```

## Send report to Danger

```swift
summary.report()
```

## Warning and Errors count

```swift
if summary.errorsCount > maxErrorCount {
  fail("There are more than \(maxErrorCount) errors"
}

if summary.warningsCount > maxWarningsCount {
  fail("There are more than \(maxWarningsCount) warnings"
}
```

## Filtering results
Don't show warnings:

```swift
let summary = XCodeSummary(json: JSONFile.jsonObject(fromString: reportTestJSON), dsl: dsl, resultsFilter: { result in
    return result.category != .warning
})
summary.report()
```

Filter out any error or warning for a specific path:

```swift
let summary = XCodeSummary(json: JSONFile.jsonObject(fromString: warningsJSON), dsl: dsl, resultsFilter: { result in
    guard let file = result.file else { return true }
    return !file.contains("Sources/DangerXCodeSummary/")
})
summary.report()
```
