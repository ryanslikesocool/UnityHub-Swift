import Foundation
import UnityHubCommon

public protocol CacheFileProtocol: SingletonFileProtocol {
	static var category: CacheCategory { get }
}

// MARK: - Default Implementation

public extension CacheFileProtocol {
	static var fileURL: URL {
		URL.persistentStorageDirectory
			.appending(path: "\(category.fileName).plist", directoryHint: .notDirectory)
	}
}
