
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
        
        let message = "**\(testSuite)**: \(testCase), \(reason)"
        let (file, line) = try FilePathParser.parseFilePath(filePath: filePath)
        
        return Result(message: message, file: file, line: line)
    }
}
