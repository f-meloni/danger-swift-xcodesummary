# DangerXCodeSummary
A Danger-Swift plugin that adds build errors, warnings and unit tests results generated from xcodebuild to your Danger report

Inspired by [danger-xcode_summary](https://github.com/diogot/danger-xcode_summary)

## Getting Started

- Install [xcpretty](https://github.com/supermarin/xcpretty) and 
[xcpretty-json-formatter](https://github.com/marcelofabri/xcpretty-json-formatter) 

- Add this to your `Dangerfile.swift`

```swift
import DangerPlugin // package: https://github.com/f-meloni/danger-swift-xcodesummary

let summary = XCodeSummary(filePath: "result.json")
```

- Generate the report file on CI before run Danger-swift
```bash
#!/bin/bash

xcodebuild | XCPRETTY_JSON_FILE_OUTPUT=result.json xcpretty -f `xcpretty-json-formatter`
```


## Run with SPM
This can be used with SPM as well (this repo uses it on the Linux CI as well), but at the moment falining tests inline messages are not generated if you use SPM.
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
