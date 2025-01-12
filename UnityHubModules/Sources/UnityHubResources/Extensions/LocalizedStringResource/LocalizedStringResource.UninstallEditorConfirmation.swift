import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static let uninstallEditorConfirmation = UninstallEditorConfirmation.self

	/// ## Topics
	/// - ``uninstallEditorConfirmation``
	enum UninstallEditorConfirmation {
		private static let localizationTable = LocalizationTableResource("UninstallEditorConfirmation")

		public static let title = LocalizedStringResource("TITLE", table: localizationTable)
		public static let message = LocalizedStringResource("MESSAGE", table: localizationTable)
	}
}
