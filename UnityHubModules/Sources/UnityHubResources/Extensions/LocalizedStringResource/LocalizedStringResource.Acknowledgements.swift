import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static let credits = Credits.self

	/// ## Topics
	/// - ``credits``
	enum Credits {
		private static let localizationTable = LocalizationTableResource("Credits")

		public static let group = Group.self
		public static let link = Link.self

		/// ## Topics
		/// - ``group``
		public enum Group {
			public static let acknowledgements = LocalizedStringResource("ITEM.ACKNOWLEDGEMENTS", table: localizationTable)
			public static let contributors = LocalizedStringResource("ITEM.CONTRIBUTORS", table: localizationTable)
		}

		/// ## Topics
		/// - ``link``
		public enum Link {
			public static let github = LocalizedStringResource("LINK.GITHUB", table: localizationTable)
			public static let license = LocalizedStringResource("LINK.LICENSE", table: localizationTable)
			public static let website = LocalizedStringResource("LINK.WEBSITE", table: localizationTable)
		}
	}
}
