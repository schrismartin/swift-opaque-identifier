import XCTest
@testable import OpaqueIdentifier

final class OpaqueIdentifierTestHelperTests: XCTestCase {
  func testRandomHelper() throws {
    let id: OpaqueIdentifier = .random
    XCTAssertEqual(ObjectIdentifier(id.underlyingType), ObjectIdentifier(UUID.self))
    XCTAssertEqual(id.data.count, 16) // 16bytes x 8bits = 128bit UUID
  }
  
  func testStableHelper() throws {
    for var nonce in 0 ..< 1_000_000 {
      let id: OpaqueIdentifier = .stable(nonce: nonce)
      XCTAssertEqual(id.data, Data(bytes: &nonce, count: MemoryLayout.size(ofValue: nonce)))
    }
  }
}
