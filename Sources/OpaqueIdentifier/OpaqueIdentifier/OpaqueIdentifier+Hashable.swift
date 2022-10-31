import Foundation

extension OpaqueIdentifier: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(ObjectIdentifier(underlyingType.self))
    hasher.combine(data)
  }
}
