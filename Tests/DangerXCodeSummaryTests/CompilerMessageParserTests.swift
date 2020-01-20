import XCTest
@testable import DangerXCodeSummary

final class CompilerMessageParserTests: XCTestCase {
    func testItParsesCorrectlyACompilerMessage() {
        let json = JSONFile.jsonObject(fromString: compilerErrorJSON)
        let errors = json["compile_errors"] as! [[String:Any]]
        
        let parsedMessage = try! CompilerMessageParser.parseMessage(messageJSON: errors[0], category: .error)
        
        XCTAssertEqual(parsedMessage.message, "use of undeclared identifier 'trololo'")
        XCTAssertEqual(parsedMessage.file, "/Users/musalj/code/OSS/ObjectiveSugar/Classes/NSNumber+ObjectiveSugar.m")
        XCTAssertEqual(parsedMessage.line, 26)
        XCTAssertEqual(parsedMessage.category, .error)
    }
}
