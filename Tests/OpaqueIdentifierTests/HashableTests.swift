import XCTest
@testable import OpaqueIdentifier

final class OpaqueIdentifierHashableTests: XCTestCase {
  func testNoCollisionOnIntegerBasedIDs() {
    var collection: Set<OpaqueIdentifier> = []
    collection.insert(OpaqueIdentifier(identifier: 1))
    collection.insert(OpaqueIdentifier(identifier: 2))
    XCTAssertEqual(collection.count, 2)
  }
  
  func testCollisionOnSameIntegerBasedIDs() {
    var collection: Set<OpaqueIdentifier> = []
    collection.insert(OpaqueIdentifier(identifier: 1))
    collection.insert(OpaqueIdentifier(identifier: 1))
    XCTAssertEqual(collection.count, 1)
  }
  
  func testNoCollisionOnUUIDBasedIDs() {
    var collection: Set<OpaqueIdentifier> = []
    
    let uuid1 = UUID()
    let uuid2 = UUID()
    
    collection.insert(OpaqueIdentifier(identifier: uuid1))
    collection.insert(OpaqueIdentifier(identifier: uuid2))
    XCTAssertEqual(collection.count, 2)
  }
  
  func testCollisionOnSameUUIDBasedIDs() {
    var collection: Set<OpaqueIdentifier> = []
    let uuid = UUID()
    collection.insert(OpaqueIdentifier(identifier: uuid))
    collection.insert(OpaqueIdentifier(identifier: uuid))
    XCTAssertEqual(collection.count, 1)
  }
  
  func testNoCollisionOnStringBasedIDs() {
    var collection: Set<OpaqueIdentifier> = []
    collection.insert(OpaqueIdentifier(identifier: "value"))
    collection.insert(OpaqueIdentifier(identifier: "other_value"))
    XCTAssertEqual(collection.count, 2)
  }
  
  func testCollisionOnSameStringBasedIDs() {
    var collection: Set<OpaqueIdentifier> = []
    collection.insert(OpaqueIdentifier(identifier: "value"))
    collection.insert(OpaqueIdentifier(identifier: "value"))
    XCTAssertEqual(collection.count, 1)
  }
}
