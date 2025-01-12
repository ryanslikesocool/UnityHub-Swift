import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static let removeProjectConfirmation = RemoveProjectConfirmation.self

	/// ## Topics
	/// - ``removeProjectConfirmation``
	enum RemoveProjectConfirmation {
		private static let localizationTable = LocalizationTableResource("RemoveProjectConfirmation")

		public static let title = LocalizedStringResource("TITLE", table: localizationTable)
		public static let message = LocalizedStringResource("MESSAGE", table: localizationTable)
	}
}
