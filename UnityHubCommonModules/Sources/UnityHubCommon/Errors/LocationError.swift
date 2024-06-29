import Foundation

public enum LocationError: Error {
	case missing
	case invalidType(expected: URLResourceKey)
}

// MARK: - LocalizedError

extension LocationError: LocalizedError {
	public var errorDescription: String? {
		switch self {
			case .missing: "Missing Location"
			case .invalidType: "Invalid Location Type"
		}
	}

	public var failureReason: String? {
		switch self {
			case .missing: "There is no file at the selected location."
			case let .invalidType(expected): "The selected location does not lead to a \(expected)."
		}
	}

	public var recoverySuggestion: String? {
		switch self {
			case .missing: "Select a valid location."
			case let .invalidType(expected): "Select a \(expected)."
		}
	}
}
