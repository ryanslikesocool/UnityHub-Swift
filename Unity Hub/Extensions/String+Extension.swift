import Foundation

extension String {
    mutating func trimPrefix(_ prefix: String) {
        if self.hasPrefix(prefix) {
            self = String(self.dropFirst(prefix.count))
        }
    }
}
