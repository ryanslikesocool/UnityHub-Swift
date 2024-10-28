import Foundation
import UHStorage_Common
import UnityHubCommon

public protocol SettingsFileProtocol: SingletonFileProtocol {
	static var category: SettingsCategory { get }
}

// MARK: - Default Implementation

public extension SettingsFileProtocol {
	static var fileURL: URL {
		category.fileURL
	}
}
