import Foundation

extension OpaqueIdentifier: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    
    if let int = try? container.decode(Int.self) {
      self.init(identifier: int)
    } else if let uuid = try? container.decode(UUID.self) {
      self.init(identifier: uuid)
    } else if let string = try? container.decode(String.self) {
      self.init(identifier: string)
    } else {
      throw DecodingError.typeMismatch(
        OpaqueIdentifier.self,
        DecodingError.Context(
          codingPath: container.codingPath,
          debugDescription: "" // TODO: Create debug description
        )
      )
    }
  }
}
