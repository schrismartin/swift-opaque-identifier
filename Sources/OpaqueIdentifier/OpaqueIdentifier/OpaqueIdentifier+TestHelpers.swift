import Foundation

#if DEBUG

extension OpaqueIdentifier {
  public static var random: OpaqueIdentifier {
    OpaqueIdentifier(identifier: UUID())
  }
  
  public static func stable(nonce: Int) -> Self {
    OpaqueIdentifier(identifier: nonce)
  }
}

#endif
