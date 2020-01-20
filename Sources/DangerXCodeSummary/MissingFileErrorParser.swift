
struct MissingFileErrorParser {
    enum Keys: String {
        case reason
        case filePath = "file_path"
    }
    
    static func parseMissingFileError(missingFileErrorJSON: [String:Any]) -> Result {
        let reason = missingFileErrorJSON[Keys.reason] ?? ""
        let filePath = missingFileErrorJSON[Keys.filePath] ?? ""
        
        return Result(message: "**\(reason)**: \(filePath)", category: .error)
    }
}
