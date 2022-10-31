import Foundation

public struct OpaqueIdentifier: Sendable {
  var underlyingType: any IdentifierType.Type
  var data: Data
}
