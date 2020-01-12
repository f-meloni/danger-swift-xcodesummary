import Danger
import DangerXCodeSummary
import Foundation

let danger = Danger()

let summary = XCodeSummary(filePath: "result.json")
summary.report()
