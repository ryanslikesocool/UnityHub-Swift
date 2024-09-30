import Foundation
import UnityHubCommon

public protocol CacheFile: SingletonFile {
	static var category: CacheCategory { get }
}

// MARK: - Default Implementation

public extension CacheFile {
	static var fileURL: URL {
		URL.persistentStorageDirectory
			.appending(path: "\(category.fileName).plist", directoryHint: .notDirectory)
	}
}
