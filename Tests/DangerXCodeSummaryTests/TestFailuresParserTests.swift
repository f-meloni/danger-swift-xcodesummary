import XCTest
@testable import DangerXCodeSummary

final class TestFailuresParserTests: XCTestCase {
    func testItParsesAFailedTests() {
        let json = JSONFile.jsonObject(fromString: failedTestsJSON)
        let tests = json["tests_failures"] as! [String:Any]
        let testSuite = "BlackJack_iOS_Failing_Tests.FailingCardTestCase"
        let testJSON = (tests[testSuite] as! [[String:Any]])[0]
        
        let result = try! TestFailuresParser.parseTest(testJSON: testJSON, testSuite: testSuite)
        
        XCTAssertEqual(result.message, "**\(testSuite): testAllRankCases**<br />XCTAssertEqual failed: (\"13\") is not equal to (\"12\")")
        XCTAssertEqual(result.file, "/BlackJack/Framework/Tests/Failing/FailingCardTests.swift")
        XCTAssertEqual(result.line, 19)
    }
}
