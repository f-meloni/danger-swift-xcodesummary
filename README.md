# DangerXCodeSummary
A Danger-Swift plugin that adds build errors, warnings and unit tests results generated from xcodebuild to your Danger report

Inspired by https://github.com/diogot/danger-xcode_summary

## Getting Started

Add this to your `Dangerfile.swift`

```swift
import DangerPlugin // package: https://github.com/f-meloni/danger-swift-xcodesummary

let summary = XCodeSummary(filePath: "result.json")
```

## Send report to Danger

```swift
summary.report()
```

## Warning and Errors count

```swift
if summary.errorsCount > maxErrorCount {
  fail("There are more than \(maxErrorCount) errors"
}

if summary.warningsCount > maxWarningsCount {
  fail("There are more than \(maxWarningsCount) warnings"
}
```
