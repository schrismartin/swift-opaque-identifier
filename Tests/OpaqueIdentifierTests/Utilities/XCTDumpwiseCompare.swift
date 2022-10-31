import Foundation
import XCTest

func XCTDumpwiseCompare<T>(_ a: T, _ b: T, file: StaticString = #file, line: UInt = #line) {
  var dumpA: String = ""
  var dumpB: String = ""
  
  dump(a, to: &dumpA)
  dump(b, to: &dumpB)
  
  XCTAssertEqual(dumpA, dumpB, file: file, line: line)
}
