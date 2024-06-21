import RegexBuilder

/// A [semantic versioning](https://semver.org/) number.
public struct SemanticVersion {
	// I had considered using smaller `UInt`s, but just in case...
	public typealias Integer = UInt

	public let major: Integer
	public let minor: Integer
	public let patch: Integer

	public init(major: Integer, minor: Integer, patch: Integer) {
		self.major = major
		self.minor = minor
		self.patch = patch
	}

	public init(_ major: Integer, _ minor: Integer, _ patch: Integer) {
		self.init(major: major, minor: minor, patch: patch)
	}

	public init?(text: some StringProtocol) {
		let majorRef = Reference(Integer.self)
		let minorRef = Reference(Integer.self)
		let patchRef = Reference(Integer.self)

		let regex: Regex = Regex {
			/// matches `[0].0.0`
			TryCapture(as: majorRef) {
				OneOrMore(.digit)
			} transform: { match in
				Integer(match)
			}
			
			"."

			/// matches `0.[0].0`
			TryCapture(as: minorRef) {
				OneOrMore(.digit)
			} transform: { match in
				Integer(match)
			}
			
			"."

			/// matches `0.0.[0]`
			TryCapture(as: patchRef) {
				OneOrMore(.digit)
			} transform: { match in
				Integer(match)
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
