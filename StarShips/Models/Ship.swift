import Foundation

/// Data structure that represents one ship.
struct Ship: Identifiable, Codable {
  var id: UUID = UUID()
  var name: String
  var model: String
  
  /// Create instance with properties.
  init(name: String, model: String) {
    self.name = name
    self.model = model
  }
  
  /// Use to decode from JSON.
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    name = try values.decode(String.self, forKey: .name)
    model = try values.decode(String.self, forKey: .model)
  }
  
  enum CodingKeys: String, CodingKey {
    case name, model
  }
}

// MARK: - Equatable
/// For checking equal values to avoid duplication in arrays.
extension Ship: Equatable {
  /// Checks if the ships are the same
  static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.id == rhs.id
  }
}
