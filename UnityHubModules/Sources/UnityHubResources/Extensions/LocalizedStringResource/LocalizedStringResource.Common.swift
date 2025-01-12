import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static let common = Common.self

	/// ## Topics
	/// - ``common``
	enum Common {
		private static let localizationTable = LocalizationTableResource("Common")

		public static let action = Action.self

		/// ## Topics
		/// - ``action``
		public enum Action {
			public static let add = LocalizedStringResource("ACTION.ADD", table: localizationTable)
			public static let create = LocalizedStringResource("ACTION.CREATE", table: localizationTable)
			public static let cancel = LocalizedStringResource("ACTION.CANCEL", table: localizationTable)
			public static let download = LocalizedStringResource("ACTION.DOWNLOAD", table: localizationTable)
			public static let done = LocalizedStringResource("ACTION.DONE", table: localizationTable)
			public static let locate = LocalizedStringResource("ACTION.LOCATE", table: localizationTable)
			public static let open = LocalizedStringResource("ACTION.OPEN", table: localizationTable)
			public static let pin = LocalizedStringResource("ACTION.PIN", table: localizationTable)
			public static let remove = LocalizedStringResource("ACTION.REMOVE", table: localizationTable)
			public static let reportBug = LocalizedStringResource("ACTION.REPORT_BUG", table: localizationTable)
			public static let retry = LocalizedStringResource("ACTION.RETRY", table: localizationTable)
			public static let select = LocalizedStringResource("ACTION.SELECT", table: localizationTable)
			public static let showInFinder = LocalizedStringResource("ACTION.SHOW_IN_FINDER", table: localizationTable)
			public static let sort = LocalizedStringResource("ACTION.SORT", table: localizationTable)
			public static let uninstall = LocalizedStringResource("ACTION.UNINSTALL", table: localizationTable)
		}
	}
}
