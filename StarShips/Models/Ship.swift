import Foundation

/// Data structure that represents one ship.
struct Ship: Identifiable, Decodable {
  var id: String = UUID().uuidString
  var name: String
  var model: String
}
