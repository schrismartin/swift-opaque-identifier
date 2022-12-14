import XCTest
@testable import OpaqueIdentifier

final class OpaqueIdentifierDescriptionTests: XCTestCase {
  func testDescriptionForUUID() throws {
    let id = UUID(uuidString: "DEADBEEF-DEAD-BEEF-DEAD-BEEFDEADBEEF")!
    let opaqueID = OpaqueIdentifier(identifier: id)
    XCTAssertEqual(opaqueID.description, id.uuidString)
  }
  
  func testDescriptionForInt() throws {
    let id = 1234567890
    let opaqueID = OpaqueIdentifier(identifier: id)
    XCTAssertEqual(opaqueID.description, String(describing: id))
  }
  
  func testDescriptionForAlphaString() throws {
    let id = "abcdefghijklmnopqrstuvwxyz"
    let opaqueID = OpaqueIdentifier(identifier: id)
    XCTAssertEqual(opaqueID.description, id)
  }
  
  func testDescriptionForNumericString() throws {
    let id = "1234567890"
    let opaqueID = OpaqueIdentifier(identifier: id)
    XCTAssertEqual(opaqueID.description, id)
  }
  
  func testDescriptionForUnicodeString() throws {
    let id = "๐คก๐ดโโ๏ธ๐๐ฎ๐จโ๐ฉโ๐งโ๐ง๐ง๐คณ"
    let opaqueID = OpaqueIdentifier(identifier: id)
    XCTAssertEqual(opaqueID.description, id)
  }
}
