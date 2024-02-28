import Foundation

/// Loadable tracks the state of a request is in when it is sent from the app to the API.
enum Loadable<T> {
  case notLoaded
  case loading
  case loaded(T)
  case failed(Error)
  
  /// The value of the loaded data
  var value: T? {
    switch self {
    case .loaded(let t):
      return t
    default:
      return nil
    }
  }
}
