
struct CompilerMessageParser {
    private enum Keys: String {
        case filePath = "file_path"
        case reason
    }
    
    enum ParsingErrors: Error {
        case invalidJSON
    }
    
    static func parseMessage(messageJSON: [String:Any], category: Result.Category) throws -> Result {
        guard let reason: String = messageJSON[Keys.reason],
            let filePath: String = messageJSON[Keys.filePath] else {
                throw ParsingErrors.invalidJSON
        }
        
        let (file, line) = try FilePathParser.parseFilePath(filePath: filePath)
        
        return Result(message: reason, file: file, line: line, category: category)
    }
}
