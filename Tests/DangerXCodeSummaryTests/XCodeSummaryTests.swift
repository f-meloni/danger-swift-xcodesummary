import XCTest
@testable import DangerXCodeSummary
import Danger
import DangerFixtures

final class XCodeSummaryTests: XCTestCase {
    func testItParsesWarningsCorrectly() {
        let summary = XCodeSummary(json: JSONFile.jsonObject(fromString: warningsJSON))
        
        XCTAssertEqual(summary.warnings, [
            Result(message: "Capabilities that require entitlements from \"SampleProject/SampleProject.entitlements\" may not function in the Simulator because none of the valid provisioning profiles allowed the specified entitlements: com.apple.security.application-groups, keychain-access-groups."),
            Result(message: "Linker asked to preserve internal global: '__block_descriptor_tmp'"),
            Result(message: "Test", file: "/Users/franco/Projects/DangerXCodeSummary/Sources/DangerXCodeSummary/XCodeSummary.swift", line: 26)
        ])
    }
    
    func testItParsesErrorsCorrectly() {
        let summary = XCodeSummary(json: JSONFile.jsonObject(fromString: errorsJSON))
        
        XCTAssertEqual(summary.errors[0], Result(message: "error: Build input file cannot be found: '/Users/franco/Projects/DangerXCodeSummary/Test.swift'"))
        XCTAssertEqual(summary.errors[1], Result(message: "use of undeclared identifier 'trololo'", file: "/Users/musalj/code/OSS/ObjectiveSugar/Classes/NSNumber+ObjectiveSugar.m", line: 26))
        XCTAssertEqual(summary.errors[2], Result(message: "returning 'float' from a function with incompatible result type 'NSNumber *'", file: "/Users/musalj/code/OSS/ObjectiveSugar/Classes/NSNumber+ObjectiveSugar.m", line: 47))
        XCTAssertTrue(summary.errors.contains(Result(message: "**BlackJack_iOS_Failing_Tests.FailingCardTestCase**: testAllRankCases, XCTAssertEqual failed: (\"13\") is not equal to (\"12\") -", file: "/BlackJack/Framework/Tests/Failing/FailingCardTests.swift", line: 19)))
        XCTAssertTrue(summary.errors.contains(Result(message: "**BlackJack_iOS_Failing_Tests.FailingCardTestCase**: testAllSuitCases, XCTAssertEqual failed: (\"4\") is not equal to (\"3\") -", file: "/BlackJack/Framework/Tests/Failing/FailingCardTests.swift", line: 27)))
        XCTAssertTrue(summary.errors.contains(Result(message: "**BlackJack_Tests.DeckTestCase**: testStandardDeck, XCTAssertEqual failed: (\"52\") is not equal to (\"51\") -", file: "/BlackJack/Framework/Tests/DeckTests.swift", line: 49)))
    }
    
    func testItParsesMessagesCorrectly() {
        let summary = XCodeSummary(json: JSONFile.jsonObject(fromString: testsSummaryJSON))
        
        XCTAssertEqual(summary.messages, [
            Result(message: "Executed 3 tests, with 0 failures (0 unexpected) in 0.039 (0.055) seconds"),
            Result(message: "Executed 14 tests, with 0 failures (0 unexpected) in 0.015 (0.025) seconds")
        ])
    }
    
    func testItSendsTheCorrectReportToDanger() {
        try! DSLGitHubJSON.write(toFile: "dsl.json", atomically: true, encoding: .utf8)
        CommandLine.arguments = ["", "dsl.json", "result.json"]
        
        let danger = Danger()
        
        let summary = XCodeSummary(json: JSONFile.jsonObject(fromString: reportTestJSON))
        summary.report()
        
        XCTAssertEqual(danger.warnings.count, 1)
        XCTAssertEqual(danger.fails.count, 1)
        XCTAssertEqual(danger.messages.count, 2)
        
        try? FileManager.default.removeItem(atPath: "dsl.json")
    }
}
