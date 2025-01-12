import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static let downloadSheet = DownloadSheet.self

	/// ## Topics
	/// - ``downloadSheet``
	enum DownloadSheet {
		private static let localizationTable = LocalizationTableResource("DownloadSheet")

		public static let group = Group.self

		public static let title = LocalizedStringResource("TITLE", table: localizationTable)

		/// ## Topics
		/// - ``group``
		public enum Group {
			public static let recommended = LocalizedStringResource("GROUP.RECOMMENDED", table: localizationTable)
			public static let official = LocalizedStringResource("GROUP.OFFICIAL", table: localizationTable)
			public static let prerelease = LocalizedStringResource("GROUP.PRERELEASE", table: localizationTable)
			public static let archive = LocalizedStringResource("GROUP.ARCHIVE", table: localizationTable)
		}
	}
}