import XCTest
@testable import OpaqueIdentifier

final class OpaqueIdentifierDecodingTests: XCTestCase {
  func testDecodeUUID() throws {
    let id = UUID(uuidString: "DEADBEEF-DEAD-BEEF-DEAD-BEEFDEADBEEF")!
    let data = #"{"id":"\#(id.uuidString)"}"#.data(using: .utf8)!
    struct DecodingContainer: Decodable { var id: OpaqueIdentifier }
    let container = try JSONDecoder().decode(DecodingContainer.self, from: data)
    XCTAssertEqual(container.id, OpaqueIdentifier(identifier: id))
  }
  
  func testDecodeInt() throws {
    let id = 1234567890
    let data = #"{"id":\#(id)}"#.data(using: .utf8)!
    struct DecodingContainer: Decodable { var id: OpaqueIdentifier }
    let container = try JSONDecoder().decode(DecodingContainer.self, from: data)
    XCTAssertEqual(container.id, OpaqueIdentifier(identifier: id))
  }
  
  func testDecodeAlphaString() throws {
    let id = "abcdefghijklmnopqrstuvwxyz"
    let data = #"{"id":"\#(id)"}"#.data(using: .utf8)!
    struct DecodingContainer: Decodable { var id: OpaqueIdentifier }
    let container = try JSONDecoder().decode(DecodingContainer.self, from: data)
    XCTAssertEqual(container.id, OpaqueIdentifier(identifier: id))
  }
  
  func testDecodeNumericString() throws {
    let id = "1234567890"
    let data = #"{"id":"\#(id)"}"#.data(using: .utf8)!
    struct DecodingContainer: Decodable { var id: OpaqueIdentifier }
    let container = try JSONDecoder().decode(DecodingContainer.self, from: data)
    XCTAssertEqual(container.id, OpaqueIdentifier(identifier: id))
  }
  
  func testDecodeUnicodeString() throws {
    let id = "🤡🚴‍♂️🚓👮👨‍👩‍👧‍👧🧝🤳"
    let data = #"{"id":"\#(id)"}"#.data(using: .utf8)!
    struct DecodingContainer: Decodable { var id: OpaqueIdentifier }
    let container = try JSONDecoder().decode(DecodingContainer.self, from: data)
    XCTAssertEqual(container.id, OpaqueIdentifier(identifier: id))
  }
  
  func testDecodingFailure() throws {
    let id: Double = 23.6
    let data = #"{"id":\#(id)}"#.data(using: .utf8)!
    struct DecodingContainer: Decodable {
      var id: OpaqueIdentifier
      enum CodingKeys: CodingKey {
        case id
      }
    }
    
    XCTAssertThrowsError(try JSONDecoder().decode(DecodingContainer.self, from: data)) { error in
      guard let error = error as? DecodingError else {
        return XCTFail("Thrown error was not of type DecodingError")
      }
      
      XCTDumpwiseCompare(
        error,
        DecodingError.typeMismatch(
          OpaqueIdentifier.self,
          DecodingError.Context(
            codingPath: [DecodingContainer.CodingKeys.id],
            debugDescription: "" // TODO: Create debug description
          )
        )
      )
    }
  }
}
