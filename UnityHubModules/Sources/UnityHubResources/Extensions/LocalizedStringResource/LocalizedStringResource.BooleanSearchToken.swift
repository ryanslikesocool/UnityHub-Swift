import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static let booleanSearchToken = BooleanSearchToken.self

	/// ## Topics
	/// - ``booleanSearchToken``
	enum BooleanSearchToken {
		private static let localizationTable = LocalizationTableResource("BooleanSearchToken")

		public static let item = Item.self

		/// ## Topics
		/// - ``item``
		public enum Item {
			public static let `is` = LocalizedStringResource("ITEM.IS", table: localizationTable)
			public static let isNot = LocalizedStringResource("ITEM.IS_NOT", table: localizationTable)
		}
	}
}
