import XCTest
@testable import DangerXCodeSummary

final class MissingFileErrorParserTests: XCTestCase {
    func testItParsesCorrectlyAMissingFileError() {
        let json = ["reason": "File not found",
                    "file_path": "/franco/Test.swift"]
        
        XCTAssertEqual(MissingFileErrorParser.parseMissingFileError(missingFileErrorJSON: json), Result(message: "**File not found**: /franco/Test.swift"))
    }
}
