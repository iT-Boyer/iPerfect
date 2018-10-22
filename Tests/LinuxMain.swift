import XCTest

import iPerfectTests

var tests = [XCTestCaseEntry]()
tests += iPerfectTests.allTests()
XCTMain(tests)