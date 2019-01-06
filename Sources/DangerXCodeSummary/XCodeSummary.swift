import Foundation
import Danger

public final class XCodeSummary {
    private enum WarningKeys: String {
        case warnings
        case ldWarning = "ld_warnings"
        case compileWarnings = "compile_warnings"
    }
    
    private enum ErrorKeys: String {
        case errors
        case compileErrors = "compile_errors"
        case fileMissing = "file_missing_errors"
        case undefinedSymbols = "undefined_symbols_errors"
        case duplicatedSymbols = "duplicate_symbols_errors"
        case testFailures = "tests_failures"
    }
    
    private enum MessageKeys: String {
        case testSummary = "tests_summary_messages"
    }
    
    private let json: [String:Any]
    
    lazy var warnings: [Result] = {
        let warningMessages: [String] = json[WarningKeys.warnings] ?? []
        let ldWarningMessages: [String] = json[WarningKeys.ldWarning] ?? []
        let compileWarnings: [[String:Any]] = json[WarningKeys.compileWarnings] ?? []
        
        return warningMessages.map { Result(message: $0) } +
            ldWarningMessages.map { Result(message: $0) } +
            compileWarnings.compactMap { try? CompilerMessageParser.parseMessage(messageJSON: $0) }
    }()
    
    lazy var errors: [Result] = {
        let errors: [String] = json[ErrorKeys.errors] ?? []
        let compileErrors: [[String:Any]] = json[ErrorKeys.compileErrors] ?? []
        let missingFiles: [[String:Any]] = json[ErrorKeys.fileMissing] ?? []
        let undefinedSymbols: [[String:Any]] = json[ErrorKeys.undefinedSymbols] ?? []
        let duplicatedSymbols: [[String:Any]] = json[ErrorKeys.duplicatedSymbols] ?? []
        let failedTests: [String:[[String:Any]]] = json[ErrorKeys.testFailures] ?? [:]
        
        var result = errors.map { Result(message: $0) }
        result += compileErrors.compactMap { try? CompilerMessageParser.parseMessage(messageJSON: $0) }
        result += missingFiles.compactMap { try? CompilerMessageParser.parseMessage(messageJSON: $0) }
        result += undefinedSymbols.map { SymbolsErrorsParser.parseUndefinedSymbols(json: $0) }
        result += duplicatedSymbols.map { SymbolsErrorsParser.parseDuplicatedSymbols(json: $0) }
        
        result += failedTests.flatMap { (key, value) in
            return value.compactMap {
                try? TestFailuresParser.parseTest(testJSON: $0, testSuite: key)
            }
        }
        
        return result
    }()
    
    lazy var messages: [Result] = {
        let messages: [String] = json[MessageKeys.testSummary] ?? []
        return messages.map { Result(message: $0.trimmingCharacters(in: .whitespacesAndNewlines)) }
    }()
    
    init(json: [String:Any]) {
        self.json = json
    }
    
    public convenience init(filePath: String) {
        guard let data = filePath.data(using: .utf8),
        let any = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
        let json = any as? [String:Any] else {
            fatalError("Report file invalid")
        }
        
        self.init(json: json)
    }
    
    public func report() {
        warnings.forEach {
            if let file = $0.file,
                let line = $0.line {
                warn(message: $0.message, file: file, line: line)
            } else {
                warn($0.message)
            }
        }
        
        errors.forEach {
            if let file = $0.file,
                let line = $0.line {
                fail(message: $0.message, file: file, line: line)
            } else {
                fail($0.message)
            }
        }
        
        messages.forEach { message($0.message) }
    }
}

extension Dictionary {
    subscript<T: RawRepresentable, R>(rawRappresentable: T) -> R? where T.RawValue == Key {
        return self[rawRappresentable.rawValue] as? R
    }
}

