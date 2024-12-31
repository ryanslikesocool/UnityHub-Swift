import Foundation
import UnityHubResources

public enum ApplicationError {
	case missingInfoPlist(applicationURL: URL)
	case missingInfoPlistKey(String)
	case unexpectedInfoPlistValue(key: String, expected: Any.Type)
	case infoPlistDecodingFailure
	case missingExecutable
	case invalidBundleIdentifier
}

// MARK: - Sendable

extension ApplicationError: Sendable { }

// MARK: - Error

extension ApplicationError: Error { }

// MARK: - LocalizedError

extension ApplicationError: LocalizedError {
	public var errorDescription: String? {
		let resource: LocalizedStringResource = switch self {
			case .missingInfoPlist: .applicationError.description.missingInfoPlist
			case .missingInfoPlistKey: .applicationError.description.missingInfoPlistKey
			case .unexpectedInfoPlistValue: .applicationError.description.unexpectedInfoPlistValue
			case .infoPlistDecodingFailure: .applicationError.description.infoPlistDecodingFailure
			case .missingExecutable: .applicationError.description.missingExecutable
			case .invalidBundleIdentifier: .applicationError.description.invalidBundleIdentifier
		}
		return String(localized: resource)

//		switch self {
//			case .missingInfoPlist: "Missing Info.plist"
//			case .missingInfoPlistKey: "Missing Info.plist Key"
//			case .unexpectedInfoPlistValue: "Unexpected Info.plist Value"
//			case .infoPlistDecodingFailure: "Info.plist Decoding Failure"
//			case .missingExecutable: "Missing Executable"
//			case .invalidBundleIdentifier: "Invalid Bundle Identifier"
//		}
	}

	public var failureReason: String? {
		var options = String.LocalizationOptions()
		let resource: LocalizedStringResource
		switch self {
			case .missingInfoPlist:
				resource = .applicationError.reason.missingInfoPlist
			case let .missingInfoPlistKey(key):
				options.replacements = [key]
				resource = .applicationError.reason.missingInfoPlistKey
			case let .unexpectedInfoPlistValue(key, _):
				options.replacements = [key]
				resource = .applicationError.reason.unexpectedInfoPlistValue
			case .infoPlistDecodingFailure:
				resource = .applicationError.reason.infoPlistDecodingFailure
			case .missingExecutable:
				resource = .applicationError.reason.missingExecutable
			case .invalidBundleIdentifier:
				resource = .applicationError.reason.invalidBundleIdentifier
		}
		return String(localized: resource, options: options)

//		switch self {
//			case .missingInfoPlist: "Could not locate the application's Info.plist file."
//			case let .missingInfoPlistKey(key): "Could not find the key \"\(key)\" in the application's Info.plist file."
//			case let .unexpectedInfoPlistValue(key, _): "Found an unexpected value for key \"\(key)\" in the application's Info.plist file."
//			case .infoPlistDecodingFailure: "Failed to decode the application's Info.plist file."
//			case .missingExecutable: "The application's executable is missing."
//			case .invalidBundleIdentifier: "The application's bundle identifier does not match the correct one."
//		}
	}

	public var recoverySuggestion: String? {
		let resource: LocalizedStringResource = .applicationError.recoverySuggestion
		return String(localized: resource)
		
//		"Ensure the selected application is correct."
	}
}
