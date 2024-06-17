import RegexBuilder

public struct SemanticVersion {
	public let major: UInt
	public let minor: UInt
	public let patch: UInt

	public init(major: UInt, minor: UInt, patch: UInt) {
		self.major = major
		self.minor = minor
		self.patch = patch
	}

	public init(_ major: UInt, _ minor: UInt, _ patch: UInt) {
		self.init(major: major, minor: minor, patch: patch)
	}

	public init?(text: some StringProtocol) {
		let majorRef = Reference(UInt.self)
		let minorRef = Reference(UInt.self)
		let patchRef = Reference(UInt.self)

		let regex: Regex = Regex {
			TryCapture(as: majorRef) {
				OneOrMore(.digit)
			} transform: { match in
				UInt(match)
			}
			"."
			TryCapture(as: minorRef) {
				OneOrMore(.digit)
			} transform: { match in
				UInt(match)
			}
			"."
			TryCapture(as: patchRef) {
				OneOrMore(.digit)
			} transform: { match in
				UInt(match)
			}
		}

		guard let result = String(text).firstMatch(of: regex) else {
			return nil
		}

		major = result[majorRef]
		minor = result[minorRef]
		patch = result[patchRef]
	}

	public init?(_ text: some StringProtocol) {
		self.init(text: text)
	}
}

// MARK: - Hashable

extension SemanticVersion: Hashable { }

// MARK: - Identifiable

extension SemanticVersion: Identifiable {
	public var id: String { description }
}

// MARK: - Comparable

extension SemanticVersion: Comparable {
	public static func < (lhs: Self, rhs: Self) -> Bool {
		if lhs.major != rhs.major {
			lhs.major < rhs.major
		} else if lhs.minor != rhs.minor {
			lhs.minor < rhs.minor
		} else {
			lhs.patch < rhs.patch
		}
	}
}

// MARK: - CustomStringConvertible

extension SemanticVersion: CustomStringConvertible {
	public var description: String {
		"\(major).\(minor).\(patch)"
	}
}

// MARK: - ExpressibleByStringLiteral

extension SemanticVersion: ExpressibleByStringLiteral {
	public init(stringLiteral value: String.StringLiteralType) {
		self = Self(text: value) ?? .zero
	}
}

// MARK: - Constants

public extension SemanticVersion {
	static let min: Self = Self(.min, .min, .min)
	static let max: Self = Self(.max, .max, .max)
	
	static let zero: Self = Self(.zero, .zero, .zero)
}
