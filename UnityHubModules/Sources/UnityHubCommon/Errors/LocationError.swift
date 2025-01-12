import Foundation
import UnityHubResources

public enum LocationError {
	case missing
	case invalidType(expected: URLResourceKey)
}

// MARK: - Sendable

extension LocationError: Sendable { }

// MARK: - Error

extension LocationError: Error { }

// MARK: - LocalizedError

extension LocationError: LocalizedError {
	public var errorDescription: String? {
		let resource: LocalizedStringResource = switch self {
			case .missing: .locationError.description.missing
			case .invalidType: .locationError.description.invalidType
		}
		return String(localized: resource)
	}

	public var failureReason: String? {
		var options = String.LocalizationOptions()
		let resource: LocalizedStringResource

		switch self {
			case .missing:
				resource = .locationError.reason.missing
			case let .invalidType(expected):
				options.replacements = [String(describing: expected)]
				resource = .locationError.reason.invalidType
		}

		return String(localized: resource, options: options)
	}

	public var recoverySuggestion: String? {
		var options = String.LocalizationOptions()
		let resource: LocalizedStringResource

		switch self {
			case .missing:
				resource = .locationError.recoverySuggestion.missing
			case let .invalidType(expected):
				options.replacements = [String(describing: expected)]
				resource = .locationError.recoverySuggestion.invalidType
		}

		return String(localized: resource, options: options)
	}
}
