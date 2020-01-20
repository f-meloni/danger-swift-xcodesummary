
struct TestFailuresParser {
    enum Keys: String {
        case testCase = "test_case"
        case reason
        case filePath = "file_path"
    }
    
    static func parseTest(testJSON: [String:Any], testSuite: String) throws -> Result {
        let testCase = testJSON[Keys.testCase] ?? ""
        let reason = testJSON[Keys.reason] ?? ""
        let filePath = testJSON[Keys.filePath] ?? ""
        
        let message = "**\(testSuite): \(testCase)**<br />\(reason.deletingSuffix(" -").deletingSuffix(" - "))"
        let (file, line) = try FilePathParser.parseFilePath(filePath: filePath)
        
        return Result(message: message, file: file, line: line, category: .error)
    }
}


private extension String {
    func deletingSuffix(_ suffix: String) -> String {
        guard hasSuffix(suffix) else { return String(self) }
        return String(dropLast(suffix.count))
    }
}
