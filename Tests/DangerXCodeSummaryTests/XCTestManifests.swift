import XCTest

extension CompilerMessageParserTests {
    static let __allTests = [
        ("testItParsesCorrectlyACompilerMessage", testItParsesCorrectlyACompilerMessage),
    ]
}

extension FilePathParserTests {
    static let __allTests = [
        ("testItParsesCorrectlyTheLineAndThePath", testItParsesCorrectlyTheLineAndThePath),
        ("testItThrowsIfThePathIsInvalid", testItThrowsIfThePathIsInvalid),
    ]
}

extension TestFailuresParserTests {
    static let __allTests = [
        ("testItParsesAFailedTests", testItParsesAFailedTests),
    ]
}

extension XCodeSummaryTests {
    static let __allTests = [
        ("testItParsesErrorsCorrectly", testItParsesErrorsCorrectly),
        ("testItParsesMessagesCorrectly", testItParsesMessagesCorrectly),
        ("testItParsesWarningsCorrectly", testItParsesWarningsCorrectly),
        ("testItSendsTheCorrectReportToDanger", testItSendsTheCorrectReportToDanger),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CompilerMessageParserTests.__allTests),
        testCase(FilePathParserTests.__allTests),
        testCase(TestFailuresParserTests.__allTests),
        testCase(XCodeSummaryTests.__allTests),
    ]
}
#endif
