import Foundation

/// Data structure that represents one ship.
struct Ship: Identifiable, Codable {
  /// The ID is not available from the API, so create one based on the name and model.
  var id: String {
    name+model.md5
  }
  var name: String
  var model: String
  var manufacturer: String
  var starshipClass: String
  
  /// Create instance with properties.
  init(name: String, model: String, manufacturer: String, starShipClass: String) {
    self.name = name
    self.model = model
    self.manufacturer = manufacturer
    self.starshipClass = starShipClass
  }
  
  /// Use to decode from JSON.
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    name = try values.decode(String.self, forKey: .name)
    model = try values.decode(String.self, forKey: .model)
    manufacturer = try values.decode(String.self, forKey: .manufacturer)
    starshipClass = try values.decode(String.self, forKey: .starshipClass)
  }
  
  enum CodingKeys: String, CodingKey {
    case name, model, manufacturer, starshipClass = "starship_class"
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

// MARK: - Array extension
extension Array where Element == Ship {
  /// Extends removeAll() but also removes it from local store.
  mutating func removeAllWithStore(where shouldBeRemoved: (Element) throws -> Bool) rethrows {
    if let ship = try self.first(where: shouldBeRemoved) {
      Shared.storage.deleteShip(ship)
    }
    try self.removeAll(where: shouldBeRemoved)
  }
  
  /// Extends append() but also adds it to local store.
  mutating func appendWithStore(_ newElement: Element) {
    self.append(newElement)
    do {
      try Shared.storage.saveShip(newElement)
    } catch StoreError.saveFailed(let message) {
      print(message)
    } catch {
      print("An unknown error has occured.")
    }
  }
}
