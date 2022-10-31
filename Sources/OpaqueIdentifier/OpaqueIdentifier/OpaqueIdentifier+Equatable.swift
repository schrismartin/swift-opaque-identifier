import Foundation

extension OpaqueIdentifier: Equatable {
  public static func == (lhs: OpaqueIdentifier, rhs: OpaqueIdentifier) -> Bool {
    return ObjectIdentifier(lhs.underlyingType) == ObjectIdentifier(rhs.underlyingType)
    && lhs.data == rhs.data
  }
}
