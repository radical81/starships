import Foundation

/// A singleton that stores service instances.
struct Shared {
  /// An Instance of the star ship data retriever.
  /// It is of type  CollectionRetriever and the implementation instance is StarShipRetriever().
  /// This can be changed later on to point to a different API.
  static let DataFetcher: CollectionRetriever = StarShipRetriever()
  /// An instance of the local store.
  static let storage: Storage = LocalStore()
}
