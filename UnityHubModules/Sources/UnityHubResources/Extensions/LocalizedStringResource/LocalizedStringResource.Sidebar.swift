import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static let sidebar = Sidebar.self

	/// ## Topics
	/// - ``sidebar``
	enum Sidebar {
		private static let localizationTable = LocalizationTableResource("Sidebar")

		public static let item = Item.self

		/// ## Topics
		/// - ``item``
		public enum Item {
			public static let projects = LocalizedStringResource("ITEM.PROJECTS", table: localizationTable)
			public static let installations = LocalizedStringResource("ITEM.INSTALLATIONS", table: localizationTable)
			public static let resources = LocalizedStringResource("ITEM.RESOURCES", table: localizationTable)
		}
	}
}
