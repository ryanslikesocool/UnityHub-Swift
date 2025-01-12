import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static let appearancePicker = AppearancePicker.self

	/// ## Topics
	/// - ``appearancePicker``
	enum AppearancePicker {
		private static let localizationTable = LocalizationTableResource("AppearancePicker")

		public static let label = LocalizedStringResource("LABEL", table: localizationTable)

		public static let item = Item.self

		/// ## Topics
		/// - ``item``
		public enum Item {
			public static let system = LocalizedStringResource("ITEM.SYSTEM", table: localizationTable)
			public static let light = LocalizedStringResource("ITEM.LIGHT", table: localizationTable)
			public static let dark = LocalizedStringResource("ITEM.DARK", table: localizationTable)
		}
	}
}
