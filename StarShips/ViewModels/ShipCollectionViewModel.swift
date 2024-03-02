import Foundation

/// Represents the data source for the ship collection view.
struct ShipCollectionViewModel {
  var dataForLoading: Loadable<[Ship]>
  var favourites: [Ship]
  
  init(_ dataForLoading: Loadable<[Ship]>, favourites: [Ship]) {
    self.dataForLoading = dataForLoading
    self.favourites = favourites
  }
  
  // MARK: - Computed Properties
  /// The array of star ships.
  var ships: [Ship] {
    switch dataForLoading {
    case .loaded(let t):
      return t
    default:
      return []
    }
  }
  /// True if fetching data is in progress.
  var isWaiting: Bool {
    switch dataForLoading {
    case .loading:
      return true
    default:
      return false
    }
  }
  /// True if fetching resulted in an error.
  var isError: Bool {
    switch dataForLoading {
    case .failed:
      return true
    default:
      return false
    }
  }
  /// The error message
  var errorMessage: String {
    switch dataForLoading {
    case .failed(let error):
      if let error = error as? APIError {
        return error.message
      }
    default: break
    }
    return "Unknown error."
  }
  /// True if the ship is a favourite.
  func isFavourite(_ ship: Ship) -> Bool {
    favourites.contains(ship)
  }
}
