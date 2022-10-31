import Foundation

extension OpaqueIdentifier {
  init(identifier: Int) {
    var identifier = identifier
    self.init(
      underlyingType: Int.self,
      data: Data(bytes: &identifier, count: MemoryLayout.size(ofValue: identifier))
    )
  }
  
  init(identifier: UUID) {
    var identifier = identifier
    self.init(
      underlyingType: UUID.self,
      data: Data(bytes: &identifier, count: MemoryLayout.size(ofValue: identifier))
    )
  }
  
  init(identifier: String) {
    self.init(
      underlyingType: String.self,
      data: identifier.data(using: .utf8)!
    )
  }
}

extension OpaqueIdentifier {
  var intValue: Int {
    data.withUnsafeBytes { $0.load(as: Int.self) }
  }
  
  var uuidValue: UUID {
    data.withUnsafeBytes { pointer in
      let uuidT = pointer.load(as: uuid_t.self)
      return UUID(uuid: uuidT)
    }
  }
  
  var stringValue: String {
    String(data: data, encoding: .utf8)!
  }
}
