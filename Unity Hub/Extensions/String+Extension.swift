import Foundation

extension String {
    mutating func trimPrefix(_ prefix: String) {
        if self.hasPrefix(prefix) {
            self = String(self.dropFirst(prefix.count))
        }
    }
}

extension String: Unwrappable {
	init(unwrap any: Any?, _ default: String = "") {
		self = any as? String ?? `default`
	}
}
