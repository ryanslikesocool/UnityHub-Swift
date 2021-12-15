protocol Unwrappable {
	init(unwrap any: Any?, _ default: Self)
}

extension Unwrappable {
	init(unwrap any: Any?, _ default: Self) {
		self = any as? Self ?? `default`
	}
}

extension RawRepresentable where RawValue == String {
	init(unwrap any: Any?, _ default: Self) {
		guard let str = any as? String else {
			self = `default`
			return
		}
		self = .init(rawValue: str) ?? `default`
	}
}

extension RawRepresentable where RawValue == Int {
	init(unwrap any: Any?, _ default: Self) {
		guard let str = any as? Int else {
			self = `default`
			return
		}
		self = .init(rawValue: str) ?? `default`
	}
}

extension RawRepresentable where RawValue == UInt {
	init(unwrap any: Any?, _ default: Self) {
		guard let str = any as? UInt else {
			self = `default`
			return
		}
		self = .init(rawValue: str) ?? `default`
	}
}

extension RawRepresentable where RawValue == Float {
	init(unwrap any: Any?, _ default: Self) {
		guard let str = any as? Float else {
			self = `default`
			return
		}
		self = .init(rawValue: str) ?? `default`
	}
}

extension RawRepresentable where RawValue == Double {
	init(unwrap any: Any?, _ default: Self) {
		guard let str = any as? Double else {
			self = `default`
			return
		}
		self = .init(rawValue: str) ?? `default`
	}
}

extension Bool: Unwrappable {}
extension Float: Unwrappable {}
extension Double: Unwrappable {}
extension String: Unwrappable {}
extension Int: Unwrappable {}

extension UInt: Unwrappable {
	init(unwrap any: Any?, _ default: Self) {
		if let raw = any as? Self {
			self = raw
		} else if let string = any as? String {
			self = Self(string.dropFirst(2), radix: 16) ?? `default`
		} else {
			self = `default`
		}
	}
}
