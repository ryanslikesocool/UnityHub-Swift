import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static let missingProjectConfirmation = MissingProjectConfirmation.self

	/// ## Topics
	/// - ``missingProjectConfirmation``
	enum MissingProjectConfirmation {
		private static let localizationTable = LocalizationTableResource("MissingProjectConfirmation")

		public static let title = LocalizedStringResource("TITLE", table: localizationTable)
		public static let message = LocalizedStringResource("MESSAGE", table: localizationTable)
	}
}
