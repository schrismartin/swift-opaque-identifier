import XCTest
@testable import OpaqueIdentifier

final class OpaqueIdentifierEncodingTests: XCTestCase {
  func testEncodeUUID() throws {
    let rawID = UUID(uuidString: "DEADBEEF-DEAD-BEEF-DEAD-BEEFDEADBEEF")!
    let id = OpaqueIdentifier(identifier: rawID)
    
    let rawIDData = try JSONEncoder().encode(rawID)
    let opaqueIDData = try JSONEncoder().encode(id)
    
    XCTAssertEqual(opaqueIDData, rawIDData)
  }
  
  func testEncodeInt() throws {
    let rawID = 1234567890
    let id = OpaqueIdentifier(identifier: rawID)
    
    let rawIDData = try JSONEncoder().encode(rawID)
    let opaqueIDData = try JSONEncoder().encode(id)
    
    XCTAssertEqual(opaqueIDData, rawIDData)
  }
  
  func testEncodeAlphaString() throws {
    let rawID = "abcdefghijklmnopqrstuvwxyz"
    let id = OpaqueIdentifier(identifier: rawID)
    
    let rawIDData = try JSONEncoder().encode(rawID)
    let opaqueIDData = try JSONEncoder().encode(id)
    
    XCTAssertEqual(opaqueIDData, rawIDData)
  }
  
  func testEncodeNumericString() throws {
    let rawID = "1234567890"
    let id = OpaqueIdentifier(identifier: rawID)
    
    let rawIDData = try JSONEncoder().encode(rawID)
    let opaqueIDData = try JSONEncoder().encode(id)
    
    XCTAssertEqual(opaqueIDData, rawIDData)
  }
  
  func testEncodeUnicodeString() throws {
    let rawID = "🤡🚴‍♂️🚓👮👨‍👩‍👧‍👧🧝🤳"
    let id = OpaqueIdentifier(identifier: rawID)
    
    let rawIDData = try JSONEncoder().encode(rawID)
    let opaqueIDData = try JSONEncoder().encode(id)
    
    XCTAssertEqual(opaqueIDData, rawIDData)
  }
  
  func testEncodingFailure() throws {
    var rawID: Double = 23.7
    let id = OpaqueIdentifier(
      underlyingType: Double.self,
      data: Data(bytes: &rawID, count: MemoryLayout.size(ofValue: rawID))
    )
    
    XCTAssertThrowsError(try JSONEncoder().encode(id)) { error in
      guard let error = error as? EncodingError else {
        return XCTFail("Thrown error was not of type EncodingError")
      }
      
      XCTDumpwiseCompare(
        error,
        EncodingError.invalidValue(
          id,
          EncodingError.Context(
            codingPath: [],
            debugDescription: ""
          )
        )
      )
    }
  }
}

// For testing purposes.
extension Double: IdentifierType { }
