import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static let backgroundModePicker = BackgroundModePicker.self

	enum BackgroundModePicker {
		private static let localizationTable = LocalizationTableResource("BackgroundModePicker")

		public static let label = LocalizedStringResource("LABEL", table: localizationTable)
		public static let description = LocalizedStringResource("DESCRIPTION", table: localizationTable)

		public static let item = Item.self

		public enum Item {
			public static let none = LocalizedStringResource("ITEM.NONE", table: localizationTable)
			public static let hide = LocalizedStringResource("ITEM.HIDE", table: localizationTable)
			public static let quit = LocalizedStringResource("ITEM.QUIT", table: localizationTable)
		}
	}
}
