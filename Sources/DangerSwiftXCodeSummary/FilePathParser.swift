import Foundation

struct FilePathParser {
    enum Errors: Error {
        case invalidPath
    }
    
    static func parseFilePath(filePath: String) throws -> (path: String, line: Int?) {
        let regex = try NSRegularExpression(pattern: "(.*?):(\\d*):?\\d*$", options: .allowCommentsAndWhitespace)
        
        let match = regex.firstMatch(in: filePath, options: .anchored, range: NSRange(0..<filePath.count))
        
        guard let pathGroup = match?.range(at: 1),
            let pathRange = Range<String.Index>(pathGroup, in: filePath) else {
            throw Errors.invalidPath
        }
        
        let path = filePath[pathRange]
        
        if let lineGroup = match?.range(at: 2),
            let lineRange = Range<String.Index>(lineGroup, in: filePath) {
            
            let line = filePath[lineRange]
            
            return (String(path), Int(line))
        } else {
            return (String(path), nil)
        }
    }
}
