import Foundation
import CryptoKit

/// Extend String for convenience.
extension String {
  var md5: String {
    let computed = Insecure.MD5.hash(data: self.data(using: .utf8)!)
    return computed.map { String(format: "%02hhx", $0) }.joined()
  }
}
