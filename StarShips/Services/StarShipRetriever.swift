import Foundation

/// Implements the CollectionRetriever for retrieving star ship data.
struct StarShipRetriever: CollectionRetriever {
  var baseUrl: String {
    "https://swapi.dev/api/starships/"
  }
  
  func fetchCollection() async -> Loadable<[Ship]> {
    // TODO: fetch data
    return .notLoaded
  }  
}
