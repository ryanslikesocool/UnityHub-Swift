import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static let locationError = LocationError.self

	enum LocationError {
		private static let localizationTable = LocalizationTableResource("LocationError")

		public static let description = Description.self
		public static let reason = Reason.self
		public static let recoverySuggestion = RecoverySuggestion.self

		public enum Description {
			public static let missing = LocalizedStringResource("DESCRIPTION.MISSING", table: localizationTable)
			public static let invalidType = LocalizedStringResource("DESCRIPTION.INVALID_TYPE", table: localizationTable)
		}

		public enum Reason {
			public static let missing = LocalizedStringResource("REASON.MISSING", table: localizationTable)
			public static let invalidType = LocalizedStringResource("REASON.INVALID_TYPE_%@", table: localizationTable)
		}

		public enum RecoverySuggestion {
			public static let missing = LocalizedStringResource("RECOVERY_SUGGESTION.MISSING", table: localizationTable)
			public static let invalidType = LocalizedStringResource("RECOVERY_SUGGESTION.INVALID_TYPE_%@", table: localizationTable)
		}
	}
}
