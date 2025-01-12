import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static let visibilityMenu = VisibilityMenu.self

	/// ## Topics
	/// - ``visibilityMenu``
	enum VisibilityMenu {
		private static let localizationTable = LocalizationTableResource("VisibilityMenu")

		public static let group = Group.self
		public static let item = Item.self

		/// ## Topics
		/// - ``group``
		public enum Group {
			public static let editor = LocalizedStringResource("GROUP.EDITOR", table: localizationTable)
		}

		/// ## Topics
		/// - ``item``
		public enum Item {
			public static let badge = LocalizedStringResource("ITEM.BADGE", table: localizationTable)
			public static let icon = LocalizedStringResource("ITEM.ICON", table: localizationTable)
			public static let lastOpened = LocalizedStringResource("ITEM.LAST_OPENED", table: localizationTable)
			public static let location = LocalizedStringResource("ITEM.LOCATION", table: localizationTable)
			public static let version = LocalizedStringResource("ITEM.VERSION", table: localizationTable)
		}
	}
}
