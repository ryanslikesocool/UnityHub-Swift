import Foundation

extension Bool {
	static var macOS12: Bool {
		guard #available(macOS 12, *) else {
			return true
		}
		return false
	}
}

extension Bool: Unwrappable {
	init(unwrap any: Any?, _ default: Bool = false) {
		self = any as? Bool ?? `default`
	}
}
