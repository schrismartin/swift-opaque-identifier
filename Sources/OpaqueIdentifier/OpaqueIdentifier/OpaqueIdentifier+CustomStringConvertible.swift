import Foundation

extension OpaqueIdentifier: CustomStringConvertible {
  public var description: String {
    switch ObjectIdentifier(underlyingType) {
    case ObjectIdentifier(Int.self):
      return String(describing: intValue)
      
    case ObjectIdentifier(UUID.self):
      return uuidValue.uuidString
      
    case ObjectIdentifier(String.self):
      return stringValue
      
    default:
      return "{{ unknown }}"
    }
  }
}
