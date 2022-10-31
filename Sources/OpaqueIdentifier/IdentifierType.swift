import Foundation

protocol IdentifierType: Equatable, Codable { }

extension Int: IdentifierType { }
extension String: IdentifierType { }
extension UUID: IdentifierType { }
