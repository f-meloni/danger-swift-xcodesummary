let errorsJSON: String = """
{
  "warnings": [

  ],
  "ld_warnings": [

  ],
  "compile_warnings": [

  ],
  "errors": [
    "error: Build input file cannot be found: '/Users/franco/Projects/DangerXCodeSummary/Test.swift'"
  ],
  "compile_errors": [
    {
      "file_name": "NSNumber+ObjectiveSugar.m",
      "file_path": "/Users/musalj/code/OSS/ObjectiveSugar/Classes/NSNumber+ObjectiveSugar.m:26:5",
      "reason": "use of undeclared identifier 'trololo'",
      "line": "    trololo",
      "cursor": "    ^"
    },
    {
      "file_name": "NSNumber+ObjectiveSugar.m",
      "file_path": "/Users/musalj/code/OSS/ObjectiveSugar/Classes/NSNumber+ObjectiveSugar.m:47:12",
      "reason": "returning 'float' from a function with incompatible result type 'NSNumber *'",
      "line": "    return (self.floatValue * 60);",
      "cursor": "           ^~~~~~~~~~~~~~~~~~~~~~"
    }
  ],
  "file_missing_errors": [

  ],
  "undefined_symbols_errors": [

  ],
  "duplicate_symbols_errors": [

  ],
  "tests_failures": {
    "BlackJack_iOS_Failing_Tests.FailingCardTestCase": [
      {
        "file_path": "/BlackJack/Framework/Tests/Failing/FailingCardTests.swift:19",
        "reason": "XCTAssertEqual failed: (\\"13\\") is not equal to (\\"12\\") -",
        "test_case": "testAllRankCases"
      },
      {
        "file_path": "/BlackJack/Framework/Tests/Failing/FailingCardTests.swift:27",
        "reason": "XCTAssertEqual failed: (\\"4\\") is not equal to (\\"3\\") -",
        "test_case": "testAllSuitCases"
      }
    ],
    "BlackJack_Tests.DeckTestCase": [
      {
        "file_path": "/BlackJack/Framework/Tests/DeckTests.swift:49",
        "reason": "XCTAssertEqual failed: (\\"52\\") is not equal to (\\"51\\") -",
        "test_case": "testStandardDeck"
      }
    ],
    "BlackJack_Tests.GameTestCase": [
      {
        "file_path": "/BlackJack/Framework/Tests/GameTests.swift:23",
        "reason": "XCTAssertEqual failed: (\\"Dealer\\") is not equal to (\\"Nooop\\") -",
        "test_case": "testInitialization"
      }
    ]
  },
  "tests_summary_messages": [
    "\\t Executed 3 tests, with 2 failures (0 unexpected) in 0.039 (0.055) seconds\\n",
    "\\t Executed 14 tests, with 2 failures (0 unexpected) in 0.015 (0.025) seconds\\n"
  ]
}
"""

