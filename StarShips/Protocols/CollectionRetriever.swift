import Foundation

/// Represents a data retrieval service to fetch data from an API.
protocol CollectionRetriever {
  /// The base URL for the API service.
  var baseUrl: String { get }
  /// The function to retrieve a collection of data.
  func fetchCollection() async -> Loadable<[Ship]>
}
