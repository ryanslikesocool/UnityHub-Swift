import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static let aboutWindow = AboutWindow.self

	/// ## Topics
	/// - ``aboutWindow``
	enum AboutWindow {
		private static let localizationTable = LocalizationTableResource("AboutWindow")

		public static let copyright = Copyright.self

		public static let developedWithLove = LocalizedStringResource("DEVELOPED_WITH_LOVE", table: localizationTable)

		/// ## Topics
		/// - ``copyright``
		public enum Copyright {
			private static let applicationFormat = LocalizedStringResource("COPYRIGHT.APPLICATION_\(placeholder: .object)", table: localizationTable)
			public static let unity = LocalizedStringResource("COPYRIGHT.UNITY", table: localizationTable)

			public static func application(copyrightHolder: String) -> String {
				let options = String.LocalizationOptions(replacements: copyrightHolder)
				return String(localized: applicationFormat, options: options)
			}
		}
	}
}
