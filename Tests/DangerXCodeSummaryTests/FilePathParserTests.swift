import XCTest
@testable import DangerXCodeSummary

final class FilePathParserTests: XCTestCase {
    func testItParsesCorrectlyTheLineAndThePath() {
        let filePath = "/Users/musalj/code/OSS/ObjectiveRecord/Example/SampleProjectTests/FindersAndCreatorsTests.m:111"
        
        let fileManager = StubbedFileManager()
        fileManager.stubbedCurrentDirectoryPath = "/Users/musalj/code/OSS/ObjectiveRecord"
        let result = try? FilePathParser.parseFilePath(filePath: filePath, fileManager: fileManager)
        
        XCTAssertEqual(result?.path, "Example/SampleProjectTests/FindersAndCreatorsTests.m")
        XCTAssertEqual(result?.line, 111)
    }
    
    func testItThrowsIfThePathIsInvalid() {
        let filePath = "/Users/musalj/code/OSS/ObjectiveRecord/Example/SampleProjectTests/FindersAndCreatorsTests.m"

        XCTAssertThrowsError(try FilePathParser.parseFilePath(filePath: filePath))
    }
}

private final class StubbedFileManager: FileManager {
    var stubbedCurrentDirectoryPath: String!
    
    override var currentDirectoryPath: String {
        return stubbedCurrentDirectoryPath
    }
}
