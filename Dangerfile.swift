import Danger
import DangerXCodeSummary // package: .

let danger = Danger()

let summary = XCodeSummary(filePath: "result.json")
summary.report()
