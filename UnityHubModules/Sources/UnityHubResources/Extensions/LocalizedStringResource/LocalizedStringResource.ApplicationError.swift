import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static let applicationError = ApplicationError.self

	enum ApplicationError {
		private static let localizationTable = LocalizationTableResource("ApplicationError")

		public static let description = Description.self
		public static let reason = Reason.self

		public static let recoverySuggestion = LocalizedStringResource("RECOVERY_SUGGESTION", table: localizationTable)

		public enum Description {
			public static let missingInfoPlist = LocalizedStringResource("DESCRIPTION.MISSING_INFO_PLIST", table: localizationTable)
			public static let missingInfoPlistKey = LocalizedStringResource("DESCRIPTION.MISSING_INFO_PLIST_KEY", table: localizationTable)
			public static let unexpectedInfoPlistValue = LocalizedStringResource("DESCRIPTION.UNEXPECTED_INFO_PLIST_VALUE", table: localizationTable)
			public static let infoPlistDecodingFailure = LocalizedStringResource("DESCRIPTION.INFO_PLIST_DECODING_FAILURE", table: localizationTable)
			public static let missingExecutable = LocalizedStringResource("DESCRIPTION.MISSING_EXECUTABLE", table: localizationTable)
			public static let invalidBundleIdentifier = LocalizedStringResource("DESCRIPTION.INVALID_BUNDLE_IDENTIFIER", table: localizationTable)
		}

		public enum Reason {
			public static let missingInfoPlist = LocalizedStringResource("REASON.MISSING_INFO_PLIST", table: localizationTable)
			public static let missingInfoPlistKey = LocalizedStringResource("REASON.MISSING_INFO_PLIST_KEY_%@", table: localizationTable)
			public static let unexpectedInfoPlistValue = LocalizedStringResource("REASON.UNEXPECTED_INFO_PLIST_VALUE_%@", table: localizationTable)
			public static let infoPlistDecodingFailure = LocalizedStringResource("REASON.INFO_PLIST_DECODING_FAILURE", table: localizationTable)
			public static let missingExecutable = LocalizedStringResource("REASON.MISSING_EXECUTABLE", table: localizationTable)
			public static let invalidBundleIdentifier = LocalizedStringResource("REASON.INVALID_BUNDLE_IDENTIFIER", table: localizationTable)

//			public static func missingInfoPlistKey(_ key: String) -> String {
//				var options = String.LocalizationOptions()
//				options.replacements = [key]
//
//				return String(localized: missingInfoPlistKey, options: options)
//			}
//
//			public static func unexpectedInfoPlistValue(_ key: String) -> String {
//				var options = String.LocalizationOptions()
//				options.replacements = [key]
//
//				return String(localized: unexpectedInfoPlistValue, options: options)
//			}
		}
	}
}
