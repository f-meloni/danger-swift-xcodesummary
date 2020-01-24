let duplicatesJSON = """
{
  "warnings": [

  ],
  "ld_warnings": [
    
  ],
  "compile_warnings": [
    {
        "file_name": "XCodeSummary.swift",
        "file_path": "/Users/franco/Projects/DangerXCodeSummary/Sources/DangerXCodeSummary/XCodeSummary.swift:26:18",
        "reason": "Test",
        "line": "        #warning(\\"Test\\")",
        "cursor": "                 ^~~~~~"
    },
    {
        "file_name": "XCodeSummary.swift",
        "file_path": "/Users/franco/Projects/DangerXCodeSummary/Sources/DangerXCodeSummary/XCodeSummary.swift:26:18",
        "reason": "Test",
        "line": "        #warning(\\"Test\\")",
        "cursor": "                 ^~~~~~"
    }
  ],
  "errors": [
    "error: Build input file cannot be found: '/Users/franco/Projects/DangerXCodeSummary/Test.swift'",
    "error: Build input file cannot be found: '/Users/franco/Projects/DangerXCodeSummary/Test.swift'"
  ],
  "compile_errors": [

  ],
  "file_missing_errors": [

  ],
  "undefined_symbols_errors": [

  ],
  "duplicate_symbols_errors": [

  ],
  "tests_failures": {
  },
  "tests_summary_messages": [
    "\\t Executed 3 tests, with 0 failures (0 unexpected) in 0.039 (0.055) seconds\\n",
    "\\t Executed 3 tests, with 0 failures (0 unexpected) in 0.039 (0.055) seconds\\n"
  ]
}
"""
