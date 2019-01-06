
let compilerErrorJSON = """
{
  "warnings": [

  ],
  "ld_warnings": [

  ],
  "compile_warnings": [

  ],
  "errors": [

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
  },
  "tests_summary_messages": [

  ]
}
"""
