import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static let dialogSuppressionReset = DialogSuppressionReset.self

	enum DialogSuppressionReset {
		private static let localizationTable = LocalizationTableResource("DialogSuppressionReset")

		public static let label = LocalizedStringResource("LABEL", table: localizationTable)
		public static let description = LocalizedStringResource("DESCRIPTION", table: localizationTable)
		public static let action = LocalizedStringResource("ACTION", table: localizationTable)
	}
}
