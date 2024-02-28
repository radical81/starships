import Foundation
/// Errors with messages
protocol ErrorWithMessage: Error {
  /// Retrieve the error message.
  var message: String { get }
}
