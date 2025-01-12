import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static let sortOrderPicker = SortOrderPicker.self

	/// ## Topics
	/// - ``sortOrderPicker``
	enum SortOrderPicker {
		private static let localizationTable = LocalizationTableResource("SortMenu")

		public static let item = Item.self

		public static let title = LocalizedStringResource("TITLE", table: localizationTable)
		public static let title_short = LocalizedStringResource("TITLE.SHORT", table: localizationTable)

		/// ## Topics
		/// - ``item``
		public enum Item {
			public static let ascending = LocalizedStringResource("ITEM.ASCENDING", table: localizationTable)
			public static let descending = LocalizedStringResource("ITEM.DESCENDING", table: localizationTable)
		}
	}
}
