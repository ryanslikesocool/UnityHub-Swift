import Foundation
import RegexBuilder

/// A Unity editor version number.
public struct UnityEditorVersion {
	public typealias Integer = SemanticVersion.Integer

	public let semantic: SemanticVersion
	public let channel: Channel
	public let iteration: Integer

	public var major: Integer { semantic.major }
	public var minor: Integer { semantic.minor }
	public var patch: Integer { semantic.patch }

	public init(_ semantic: SemanticVersion, _ channel: Channel, _ iteration: Integer) {
		self.semantic = semantic
		self.channel = channel
		self.iteration = iteration
	}

	public init(_ text: some StringProtocol) throws {
		let majorRef = Reference(Integer.self)
		let minorRef = Reference(Integer.self)
		let patchRef = Reference(Integer.self)
		let channelRef = Reference(Channel.self)
		let iterationRef = Reference(Integer.self)

		let regex: Regex = Regex {
			/// matches `[0].0.0x0`
			TryCapture(as: majorRef) {
				OneOrMore(.digit)
			} transform: { match in
				Integer(match)
			}

			"."

			/// matches `0.[0].0x0`
			TryCapture(as: minorRef) {
				OneOrMore(.digit)
			} transform: { match in
				Integer(match)
			}

			"."

			/// matches `0.0.[0]x0`
			TryCapture(as: patchRef) {
				OneOrMore(.digit)
			} transform: { match in
				Integer(match)
			}

			/// matches `0.0.0[x]0`
			TryCapture(as: channelRef) {
				One(.anyOf("abfpc"))
			} transform: { match in
				Channel(match)
			}

			/// matches `0.0.0x[0]`
			TryCapture(as: iterationRef) {
				OneOrMore(.digit)
			} transform: { match in
				Integer(match)
			}
		}

		guard let result = String(text).firstMatch(of: regex) else {
			throw RegexError.noMatches
		}

		semantic = SemanticVersion(
			major: result[majorRef],
			minor: result[minorRef],
			patch: result[patchRef]
		)
		channel = result[channelRef]
		iteration = result[iterationRef]
	}

	public init?(_ text: (some StringProtocol)?) {
		guard let text else {
			return nil
		}
		try? self.init(text)
	}
}

// MARK: - Sendable

extension UnityEditorVersion: Sendable { }

// MARK: - Equatable

extension UnityEditorVersion: Equatable { }

// MARK: - Hashable

extension UnityEditorVersion: Hashable { }

// MARK: - Identifiable

extension UnityEditorVersion: Identifiable {
	public var id: String { description }
}

// MARK: - Decodable

extension UnityEditorVersion: Decodable {
	public init(from decoder: any Decoder) throws {
		let container = try decoder.singleValueContainer()
		self = try Self(container.decode(String.self))
	}
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
		self = (try? Self(value)) ?? .zero
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
	/// Is this version considered a **L**ong **T**erm **S**upport release?
	/// - Remark: Unity does not have a consistent scheme for determining LTS releases.  The value returned by this property will change in the future.
	var isLTS: Bool {
		(major == 5 && minor == 6)
			|| ((2017 ... 2019).contains(major) && minor == 4)
			|| ((2020 ... 2022).contains(major) && minor == 3)
	}

	var isPrerelease: Bool {
		channel == .alpha || channel == .beta
	}
}
