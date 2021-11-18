let filterWarningsJSON = """
{
  "warnings": [
    "Capabilities that require entitlements from \\"SampleProject/SampleProject.entitlements\\" may not function in the Simulator because none of the valid provisioning profiles allowed the specified entitlements: com.apple.security.application-groups, keychain-access-groups."
  ],
  "ld_warnings": [
    "Linker asked to preserve internal global: '__block_descriptor_tmp'"
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
        "file_name": "FilePathParser.swift",
        "file_path": "/Users/franco/Projects/DangerXCodeSummary/Sources/DangerXCodeSummary/FilePathParser.swift:26:18",
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
    },
    {
        "file_name": "ComplierMessageParser.swift",
        "file_path": "/Users/franco/Projects/DangerXCodeSummary/Sources/DangerXCodeSummary/ComplierMessageParser.swift:26:18",
        "reason": "Test",
        "line": "        #warning(\\"Test\\")",
        "cursor": "                 ^~~~~~"
    },
    {
        "file_name": "SymbolsErrorParser.swift",
        "file_path": "/Users/franco/Projects/DangerXCodeSummary/Sources/DangerXCodeSummary/SymbolsErrorParser.swift:26:18",
        "reason": "Test",
        "line": "        #warning(\\"Test\\")",
        "cursor": "                 ^~~~~~"
    }
  ],
  "errors": [

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
  ]
}
"""
