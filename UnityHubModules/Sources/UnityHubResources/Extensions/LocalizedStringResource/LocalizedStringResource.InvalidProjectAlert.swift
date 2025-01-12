import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static let invalidProjectAlert = InvalidProjectAlert.self

	/// ## Topics
	/// - ``invalidProjectAlert``
	enum InvalidProjectAlert {
		private static let localizationTable = LocalizationTableResource("InvalidProjectAlert")

		public static let title = LocalizedStringResource("TITLE", table: localizationTable)
		public static let message = LocalizedStringResource("MESSAGE", table: localizationTable)
	}
}
