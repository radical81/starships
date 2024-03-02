/// Track errors when managing local storage.
enum StoreError: ErrorWithMessage {
  /// Save error
  case saveFailed(String)
  
  var message: String {
    switch self {
    case .saveFailed(let message):
      return message
    }
  }
}
