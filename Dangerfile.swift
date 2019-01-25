import Danger
import DangerXCodeSummary

let danger = Danger()

let summary = XCodeSummary(filePath: "result.json")
summary.report()
