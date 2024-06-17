import RegexBuilder

public struct UnityEditorVersion {
	public let semantic: SemanticVersion
	public var major: UInt { semantic.major }
	public var minor: UInt { semantic.minor }
	public var patch: UInt { semantic.patch }
	public let channel: Channel
	public let iteration: UInt

	public init(_ semantic: SemanticVersion, _ channel: Channel, _ iteration: UInt) {
		self.semantic = semantic
		self.channel = channel
		self.iteration = iteration
	}

	public init?(text: some StringProtocol) {
		let majorRef = Reference(UInt.self)
		let minorRef = Reference(UInt.self)
		let patchRef = Reference(UInt.self)
		let channelRef = Reference(Channel.self)
		let iterationRef = Reference(UInt.self)

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
			TryCapture(as: channelRef) {
				One(.anyOf("abfpc"))
			} transform: { match in
				Channel(match)
			}
			TryCapture(as: iterationRef) {
				OneOrMore(.digit)
			} transform: { match in
				UInt(match)
			}
		}

		guard let result = String(text).firstMatch(of: regex) else {
			return nil
		}

		semantic = SemanticVersion(
			major: result[majorRef],
			minor: result[minorRef],
			patch: result[patchRef]
		)
		channel = result[channelRef]
		iteration = result[iterationRef]
	}

	public init?(text: (some StringProtocol)?) {
		guard let text else {
			return nil
		}
		self.init(text: text)
	}

	public init?(_ text: some StringProtocol) {
		self.init(text: text)
	}

	public init?(_ text: (some StringProtocol)?) {
		guard let text else {
			return nil
		}
		self.init(text: text)
	}
}

// MARK: - Hashable

extension UnityEditorVersion: Hashable { }

// MARK: - Identifiable

extension UnityEditorVersion: Identifiable {
	public var id: String { description }
}

// MARK: - Comparable

extension UnityEditorVersion: Comparable {
	public static func < (lhs: Self, rhs: Self) -> Bool {
		if lhs.semantic != rhs.semantic {
			lhs.semantic < rhs.semantic
		} else if lhs.channel != rhs.channel {
			lhs.channel < rhs.channel
		} else {
			lhs.iteration < rhs.iteration
		}
	}
}

// MARK: - CustomStringConvertible

extension UnityEditorVersion: CustomStringConvertible {
	public var description: String {
		"\(semantic)\(channel)\(iteration)"
	}
}

// MARK: - ExpressibleByStringLiteral

extension UnityEditorVersion: ExpressibleByStringLiteral {
	public init(stringLiteral value: String.StringLiteralType) {
		self = Self(text: value) ?? Self.zero
	}
}

// MARK: - Constants

public extension UnityEditorVersion {
	static let min: Self = Self(.min, .a, .min)
	static let max: Self = Self(.max, .c, .max)

	static let zero: Self = Self(.zero, .f, .zero)
}

// MARK: -

public extension UnityEditorVersion {
	var isLTS: Bool {
		(major == 5 && minor == 6)
			|| ((2017 ... 2019).contains(major) && minor == 4)
			|| ((2020 ... 2022).contains(major) && minor == 3)
	}
}
