import SwiftUI

/// Represents the data source for the ship collection view.
struct ShipCollectionViewModel {
  var dataForLoading: Binding<Loadable<[Ship]>>
  var favourites: [Ship]
  var sortBy: SortOption
  
  init(_ dataForLoading: Binding<Loadable<[Ship]>>, favourites: [Ship], sortBy: SortOption) {
    self.dataForLoading = dataForLoading
    self.favourites = favourites
    self.sortBy = sortBy
  }
  
  // MARK: - Computed Properties
  /// The array of star ships.
  var ships: [Ship] {
    switch dataForLoading.wrappedValue {
    case .loaded(let t):
      return t
    default:
      return []
    }
  }
  /// The sorted array of star ships.
  var sortedShips: [Ship] {
    switch sortBy {
    case .name:
      return ships.sorted{ $0.name < $1.name }
    case .model:
      return ships.sorted{ $0.model < $1.model }
    }
  }
  /// True if fetching data is in progress.
  var isWaiting: Bool {
    switch dataForLoading.wrappedValue {
    case .loading:
      return true
    default:
      return false
    }
  }
  /// True if fetching resulted in an error.
  var isError: Bool {
    switch dataForLoading.wrappedValue {
    case .failed:
      return true
    default:
      return false
    }
  }
  /// The error message
  var errorMessage: String {
    switch dataForLoading.wrappedValue {
    case .failed(let error):
      if let error = error as? APIError {
        return error.message
      }
    default: break
    }
    return "Unknown error."
  }
  // MARK: - Methods
  /// True if the ship is a favourite.
  func isFavourite(_ ship: Ship) -> Bool {
    favourites.contains(ship)
  }
  /// Call the API.
  func fetchData() async {
    dataForLoading.wrappedValue = .loading
    dataForLoading.wrappedValue = await Shared.DataFetcher.fetchCollection()
  }
}
