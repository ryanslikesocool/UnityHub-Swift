import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static let userMenu = UserMenu.self

	/// ## Topics
	/// - ``userMenu``
	enum UserMenu {
		private static let localizationTable = LocalizationTableResource("UserMenu")

		public static let group = Group.self
		public static let item = Item.self

		/// ## Topics
		/// - ``group``
		public enum Group {
			public static let troubleshooting = LocalizedStringResource("GROUP.TROUBLESHOOTING", table: localizationTable)
		}

		/// ## Topics
		/// - ``item``
		public enum Item {
			public static let accountHelp = LocalizedStringResource("ITEM.ACCOUNT_HELP", table: localizationTable)
			public static let accountSettings = LocalizedStringResource("ITEM.ACCOUNT_SETTINGS", table: localizationTable)
			public static let manageLicenses = LocalizedStringResource("ITEM.MANAGE_LICENSES", table: localizationTable)
			public static let manageOrganizations = LocalizedStringResource("ITEM.MANAGE_ORGANIZATIONS", table: localizationTable)
			public static let openLogFolder = LocalizedStringResource("ITEM.OPEN_LOG_FOLDER", table: localizationTable)
			public static let signOut = LocalizedStringResource("ITEM.SIGN_OUT", table: localizationTable)
			public static let unityCloud = LocalizedStringResource("ITEM.UNITY_CLOUD", table: localizationTable)
		}
	}
}