import XCTest
@testable import DangerXCodeSummary
@testable import Danger
import DangerFixtures

final class XCodeSummaryTests: XCTestCase {
    var dsl: DangerDSL!
    
    override func setUp() {
        super.setUp()
        dsl = githubFixtureDSL
    }
    
    override func tearDown() {
        dsl = nil
        resetDangerResults()
        
        super.tearDown()
    }
    
    func testItParsesWarningsCorrectly() {
        let summary = XCodeSummary(json: JSONFile.jsonObject(fromString: warningsJSON), dsl: dsl)
        
        XCTAssertEqual(summary.warnings, [
            Result(message: "Capabilities that require entitlements from \"SampleProject/SampleProject.entitlements\" may not function in the Simulator because none of the valid provisioning profiles allowed the specified entitlements: com.apple.security.application-groups, keychain-access-groups.", category: .warning),
            Result(message: "Linker asked to preserve internal global: '__block_descriptor_tmp'", category: .warning),
            Result(message: "Test", file: "/Users/franco/Projects/DangerXCodeSummary/Sources/DangerXCodeSummary/XCodeSummary.swift", line: 26, category: .warning)
        ])
        
        XCTAssertEqual(summary.warningsCount, 3)
    }
    
    func testItParsesErrorsCorrectly() {
        let summary = XCodeSummary(json: JSONFile.jsonObject(fromString: errorsJSON), dsl: dsl)
        
        XCTAssertEqual(summary.errors[0], Result(message: "error: Build input file cannot be found: '/Users/franco/Projects/DangerXCodeSummary/Test.swift'", category: .error))
        XCTAssertEqual(summary.errors[1], Result(message: "use of undeclared identifier 'trololo'", file: "/Users/musalj/code/OSS/ObjectiveSugar/Classes/NSNumber+ObjectiveSugar.m", line: 26, category: .error))
        XCTAssertEqual(summary.errors[2], Result(message: "returning 'float' from a function with incompatible result type 'NSNumber *'", file: "/Users/musalj/code/OSS/ObjectiveSugar/Classes/NSNumber+ObjectiveSugar.m", line: 47, category: .error))
        XCTAssertTrue(summary.errors.contains(Result(message: "**BlackJack_iOS_Failing_Tests.FailingCardTestCase: testAllRankCases**<br />XCTAssertEqual failed: (\"13\") is not equal to (\"12\")", file: "/BlackJack/Framework/Tests/Failing/FailingCardTests.swift", line: 19, category: .error)))
        XCTAssertTrue(summary.errors.contains(Result(message: "**BlackJack_iOS_Failing_Tests.FailingCardTestCase: testAllSuitCases**<br />XCTAssertEqual failed: (\"4\") is not equal to (\"3\")", file: "/BlackJack/Framework/Tests/Failing/FailingCardTests.swift", line: 27, category: .error)))
        XCTAssertTrue(summary.errors.contains(Result(message: "**BlackJack_Tests.DeckTestCase: testStandardDeck**<br />XCTAssertEqual failed: (\"52\") is not equal to (\"51\")", file: "/BlackJack/Framework/Tests/DeckTests.swift", line: 49, category: .error)))
        XCTAssertEqual(summary.errorsCount, 7)
    }
    
    func testItParsesMessagesCorrectly() {
        let summary = XCodeSummary(json: JSONFile.jsonObject(fromString: testsSummaryJSON), dsl: dsl)
        
        XCTAssertEqual(summary.messages, [
            Result(message: "Executed 30 tests, with 0 failures (0 unexpected) in 0.039 (0.055) seconds", category: .message),
            Result(message: "Executed 14 tests, with 0 failures (0 unexpected) in 0.015 (0.025) seconds", category: .message)
        ])
    }
    
    func testItSendsTheCorrectReportToDanger() {
        let summary = XCodeSummary(json: JSONFile.jsonObject(fromString: reportTestJSON), dsl: dsl)
        summary.report()
        
        XCTAssertEqual(dsl.warnings.count, 1)
        XCTAssertEqual(dsl.fails.count, 1)
        XCTAssertEqual(dsl.messages.count, 2)
        
        try? FileManager.default.removeItem(atPath: "dsl.json")
    }

    func testItFiltersWarnings() {
        let summary = XCodeSummary(json: JSONFile.jsonObject(fromString: reportTestJSON), dsl: dsl, resultsFilter: { result in
            return result.category != .warning
        })
        summary.report()
        XCTAssertEqual(dsl.warnings.count, 0)
        XCTAssertEqual(dsl.fails.count, 1)
        XCTAssertEqual(dsl.messages.count, 2)

        try? FileManager.default.removeItem(atPath: "dsl.json")
    }

    func testItFiltersMessages() {
        let summary = XCodeSummary(json: JSONFile.jsonObject(fromString: reportTestJSON), dsl: dsl, resultsFilter: { result in
            return result.category != .message
        })
        summary.report()
        XCTAssertEqual(dsl.warnings.count, 1)
        XCTAssertEqual(dsl.fails.count, 1)
        XCTAssertEqual(dsl.messages.count, 0)

        try? FileManager.default.removeItem(atPath: "dsl.json")
    }

    func testItFiltersErrors() {
        let summary = XCodeSummary(json: JSONFile.jsonObject(fromString: reportTestJSON), dsl: dsl, resultsFilter: { result in
            return result.category != .error
        })
        summary.report()
        XCTAssertEqual(dsl.warnings.count, 1)
        XCTAssertEqual(dsl.fails.count, 0)
        XCTAssertEqual(dsl.messages.count, 2)

        try? FileManager.default.removeItem(atPath: "dsl.json")
    }

    func testItFiltersFilePaths() {
        let summary = XCodeSummary(json: JSONFile.jsonObject(fromString: warningsJSON), dsl: dsl, resultsFilter: { result in
            guard let file = result.file else { return true }
            return !file.contains("Sources/DangerXCodeSummary/")
        })
        summary.report()
        XCTAssertEqual(dsl.warnings.count, 2)
        XCTAssertEqual(dsl.fails.count, 0)
        XCTAssertEqual(dsl.messages.count, 0)

        try? FileManager.default.removeItem(atPath: "dsl.json")
    }

    func testItFiltersOutDuplicates() {
        let summary = XCodeSummary(json: JSONFile.jsonObject(fromString: duplicatesJSON), dsl: dsl)
        summary.report()
        XCTAssertEqual(dsl.warnings.count, 1)
        XCTAssertEqual(dsl.fails.count, 1)
        XCTAssertEqual(dsl.messages.count, 1)

        try? FileManager.default.removeItem(atPath: "dsl.json")
    }
}
