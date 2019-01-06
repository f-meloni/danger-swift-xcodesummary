import Foundation

struct FilePathParser {
    enum Errors: Error {
        case invalidPath
    }
    
    static func parseFilePath(filePath: String, fileManager: FileManager = .default) throws -> (path: String, line: Int?) {
        let regex = try NSRegularExpression(pattern: "(.*?):(\\d*):?\\d*$", options: .allowCommentsAndWhitespace)
        
        let match = regex.firstMatch(in: filePath, options: .anchored, range: NSRange(0..<filePath.count))
        
        guard let pathGroup = match?.range(at: 1),
            let pathRange = Range<String.Index>(pathGroup, in: filePath) else {
            throw Errors.invalidPath
        }
        
        let currentPath = fileManager.currentDirectoryPath.last == "/" ? fileManager.currentDirectoryPath : fileManager.currentDirectoryPath + "/"
        let path = filePath[pathRange].deletingPrefix(currentPath)
        
        #warning("Test")
        
        if let lineGroup = match?.range(at: 2),
            let lineRange = Range<String.Index>(lineGroup, in: filePath) {
            
            let line = filePath[lineRange]
            
            return (path, Int(line))
        } else {
            return (path, nil)
        }
    }
}

private extension Substring {
    func deletingPrefix(_ prefix: String) -> String {
        guard hasPrefix(prefix) else { return String(self) }
        return String(dropFirst(prefix.count))
    }
}
