import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static let locationError = LocationError.self

	/// ## See Also
	/// - ``LocationError``
	///
	/// ## Topics
	/// - ``locationError``
	enum LocationError {
		private static let localizationTable = LocalizationTableResource("LocationError")

		public static let description = Description.self
		public static let reason = Reason.self
		public static let recoverySuggestion = RecoverySuggestion.self

		/// ## See Also
		/// - ``LocationError/errorDescription``
		///
		/// ## Topics
		/// - ``description``
		public enum Description {
			public static let missing = LocalizedStringResource("DESCRIPTION.MISSING", table: localizationTable)
			public static let invalidType = LocalizedStringResource("DESCRIPTION.INVALID_TYPE", table: localizationTable)
		}

		/// ## See Also
		/// - ``LocationError/failureReason``
		///
		/// ## Topics
		/// - ``reason``
		public enum Reason {
			public static let missing = LocalizedStringResource("REASON.MISSING", table: localizationTable)
			public static let invalidType = LocalizedStringResource("REASON.INVALID_TYPE_\(placeholder: .object)", table: localizationTable)

			public static func invalidType(_ argument: String) -> String {
				let options = String.LocalizationOptions(replacements: argument)
				return String(localized: invalidType, options: options)
			}
		}

		/// ## See Also
		/// - ``LocationError/recoverySuggestion``
		///
		/// ## Topics
		/// - ``recoverySuggestion``
		public enum RecoverySuggestion {
			public static let missing = LocalizedStringResource("RECOVERY_SUGGESTION.MISSING", table: localizationTable)
			public static let invalidType = LocalizedStringResource("RECOVERY_SUGGESTION.INVALID_TYPE_\(placeholder: .object)", table: localizationTable)

			public static func invalidType(_ argument: String) -> String {
				let options = String.LocalizationOptions(replacements: argument)
				return String(localized: invalidType, options: options)
			}
		}
	}
}
