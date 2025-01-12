import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static let missingInstallationAlert = MissingInstallationAlert.self

	/// ## Topics
	/// - ``missingInstallationAlert``
	enum MissingInstallationAlert {
		private static let localizationTable = LocalizationTableResource("MissingInstallationAlert")

		public static let title = LocalizedStringResource("TITLE", table: localizationTable)
		public static let message = LocalizedStringResource("MESSAGE", table: localizationTable)
	}
}
