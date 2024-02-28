import Foundation

/// Model to capture the responses from the API.
struct Response: Decodable {
  /// Number of ships
  var count: Int?
  /// Next page
  var next: String?
  /// Previous page
  var previous: String?
  /// List of ships
  var results: [Ship]
  
  /// Use to decode from JSON.
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    count = try values.decodeIfPresent(Int.self, forKey: .count)
    next = try values.decodeIfPresent(String.self, forKey: .next)
    previous = try values.decodeIfPresent(String.self, forKey: .previous)
    results = try values.decode([Ship].self, forKey: .results)
  }
  
  enum CodingKeys: String, CodingKey {
    case count, next, previous, results
  }
}
