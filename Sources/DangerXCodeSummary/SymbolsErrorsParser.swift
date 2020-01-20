import Foundation

struct SymbolsErrorsParser {
    private enum Keys: String {
        case message
        case symbol
        case reference
        case filePaths = "file_paths"
    }
    
    static func parseUndefinedSymbols(json: [String:Any]) -> Result {
        let message: String = json[Keys.message] ?? ""
        let symbol: String = json[Keys.symbol] ?? ""
        let reference: String = json[Keys.reference] ?? ""
        
        let resultText = "\(message)  <br />" +
        "> Symbol: \(symbol) <br />" +
        "> Referenced from: \(reference)"
        
        return Result(message: resultText, category: .error)
    }
    
    static func parseDuplicatedSymbols(json: [String:Any]) -> Result {
        let message: String = json[Keys.message] ?? ""
        let paths: [String] = json[Keys.filePaths] ?? []
        
        let resultText = "\(message) <br />" +
        "> \(paths.map { $0.split(separator: "/").last! }.joined(separator: "<br />")))"
        
        return Result(message: resultText, category: .error)
    }
}
