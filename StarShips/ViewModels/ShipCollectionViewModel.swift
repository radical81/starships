import Foundation

struct ShipCollectionViewModel {
  var dataForLoading: Loadable<[Ship]>
  
  init(_ dataForLoading: Loadable<[Ship]>) {
    self.dataForLoading = dataForLoading
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
}
