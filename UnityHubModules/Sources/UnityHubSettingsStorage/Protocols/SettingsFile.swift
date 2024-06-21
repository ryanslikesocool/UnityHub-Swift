import Foundation
import UnityHubCommon

public protocol SettingsFile: GlobalFile {
	static var category: SettingsCategory { get }
}

// MARK: - Default Implementation

public extension SettingsFile {
	static func == (lhs: Self, rhs: Self) -> Bool {
		lhs.hashValue == rhs.hashValue
	}

	static var fileURL: URL { Constant.Settings.fileURL(for: category) }
}
