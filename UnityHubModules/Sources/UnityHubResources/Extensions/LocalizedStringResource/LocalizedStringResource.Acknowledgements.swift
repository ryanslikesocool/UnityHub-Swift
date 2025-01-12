import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static let acknowledgements = Acknowledgements.self

	enum Acknowledgements {
		private static let localizationTable = LocalizationTableResource("Acknowledgements")

		public static let item = Item.self
		public static let link = Link.self

		public enum Item {
			public static let contributors = LocalizedStringResource("ITEM.CONTRIBUTORS", table: localizationTable)
			public static let dependencies = LocalizedStringResource("ITEM.DEPENDENCIES", table: localizationTable)
		}

		public enum Link {
			public static let github = LocalizedStringResource("LINK.GITHUB", table: localizationTable)
			public static let license = LocalizedStringResource("LINK.LICENSE", table: localizationTable)
			public static let website = LocalizedStringResource("LINK.WEBSITE", table: localizationTable)
		}
	}
}