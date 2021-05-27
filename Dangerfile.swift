import Danger
import DangerXCodeSummary
import DangerSwiftCoverage
import Foundation

let danger = Danger()

let summary = XCodeSummary(filePath: "result.json")
summary.report()

if FileManager.default.fileExists(atPath: "DangerXCodeSummary.xcodeproj") {
    Coverage.xcodeBuildCoverage(.derivedDataFolder("Build"), minimumCoverage: 50)
}
