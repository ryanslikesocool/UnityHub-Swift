import Foundation
import UHStorage_Common
import UnityHubCommon

public protocol SettingsFile: SingletonFile {
	static var category: SettingsCategory { get }
}

// MARK: - Default Implementation

public extension SettingsFile {
	static var fileURL: URL {
		Constant.Settings.fileURL(for: category)
	}
}
