import Foundation

public enum ApplicationError: Error {
	case missingInfoPlist(applicationURL: URL)
	case missingInfoPlistKey(String)
	case infoPlistDeserializationFailure
	case missingExecutable
	case invalidBundleIdentifier
}

// MARK: - LocalizedError

extension ApplicationError: LocalizedError {
	public var errorDescription: String? {
		switch self {
			case .missingInfoPlist: "Missing Info.plist"
			case .missingInfoPlistKey: "Missing Info.plist Key"
			case .infoPlistDeserializationFailure: "Info.plist Deserialization Failure"
			case .missingExecutable: "Missing Executable"
			case .invalidBundleIdentifier: "Invalid Bundle Identifier"
		}
	}

	public var failureReason: String? {
		switch self {
			case .missingInfoPlist: "Could not locate the application's Info.plist file."
			case let .missingInfoPlistKey(key): "Could not find the key \"\(key)\" in the application's Info.plist file."
			case .infoPlistDeserializationFailure: "Failed to deserialize the application's Info.plist file."
			case .missingExecutable: "The application's executable is missing."
			case .invalidBundleIdentifier: "The application's bundle identifier does not match the correct one."
		}
	}

	public var recoverySuggestion: String? {
		"Ensure the selected application is correct."
	}
}
