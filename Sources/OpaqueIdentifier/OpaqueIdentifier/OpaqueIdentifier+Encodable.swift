import Foundation

extension OpaqueIdentifier: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    
    switch ObjectIdentifier(underlyingType) {
    case ObjectIdentifier(Int.self):
      try container.encode(intValue)
      
    case ObjectIdentifier(UUID.self):
      try container.encode(uuidValue)
      
    case ObjectIdentifier(String.self):
      try container.encode(stringValue)
      
    default:
      throw EncodingError.invalidValue(
        self, EncodingError.Context(
          codingPath: encoder.codingPath,
          debugDescription: "" // TODO: Provide error message
        )
      )
    }
  }
}
