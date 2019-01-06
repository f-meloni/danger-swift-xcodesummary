import XCTest
@testable import DangerSwiftXCodeSummary

final class FilePathParserTests: XCTestCase {
    func testItParsesCorrectlyTheLineAndThePath() {
        let filePath = "/Users/musalj/code/OSS/ObjectiveRecord/Example/SampleProjectTests/FindersAndCreatorsTests.m:111"
        
        let result = try? FilePathParser.parseFilePath(filePath: filePath)
        
        XCTAssertEqual(result?.path, "/Users/musalj/code/OSS/ObjectiveRecord/Example/SampleProjectTests/FindersAndCreatorsTests.m")
        XCTAssertEqual(result?.line, 111)
    }
    
    func testItThrowsIfThePathIsInvalid() {
        let filePath = "/Users/musalj/code/OSS/ObjectiveRecord/Example/SampleProjectTests/FindersAndCreatorsTests.m"

        XCTAssertThrowsError(try FilePathParser.parseFilePath(filePath: filePath))
    }
}
