import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static let aboutWindow = AboutWindow.self

	enum AboutWindow {
		private static let localizationTable = LocalizationTableResource("AboutWindow")

		public static let copyright = Copyright.self

		public static let developedWithLove = LocalizedStringResource("DEVELOPED_WITH_LOVE", table: localizationTable)

		public enum Copyright {
			public static let application = LocalizedStringResource("COPYRIGHT.APPLICATION_%@", table: localizationTable)
			public static let unity = LocalizedStringResource("COPYRIGHT.UNITY", table: localizationTable)
		}
	}
}
