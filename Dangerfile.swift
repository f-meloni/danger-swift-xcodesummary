import Danger
import DangerXCodeSummary // package: .

let danger = Danger()

let summary = XCodeSummary(filePath: "report.json")
summary.report()
