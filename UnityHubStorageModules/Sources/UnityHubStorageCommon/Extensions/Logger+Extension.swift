import Foundation
import OSLog

package extension Logger {
	private static let subsystem: String = "\(Bundle.main.bundleIdentifier!).UnityHubStorage"

	init(category: String) {
		self.init(subsystem: Self.subsystem, category: category)
	}
}

extension Logger {
	static let module: Logger = Logger(category: "UnityHubStorageCommon")
}
