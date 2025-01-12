import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static let sortCriteriaPicker = SortCriteriaPicker.self

	/// ## Topics
	/// - ``sortCriteriaPicker``
	enum SortCriteriaPicker {
		private static let localizationTable = LocalizationTableResource("SortCriteriaPicker")

		public static let item = Item.self

		public static let title = LocalizedStringResource("TITLE", table: localizationTable)

		/// ## Topics
		/// - ``item``
		public enum Item {
			public static let editorVersion = LocalizedStringResource("ITEM.EDITOR_VERSION", table: localizationTable)
			public static let lastOpened = LocalizedStringResource("ITEM.LAST_OPENED", table: localizationTable)
			public static let name = LocalizedStringResource("ITEM.NAME", table: localizationTable)
		}
	}
}
